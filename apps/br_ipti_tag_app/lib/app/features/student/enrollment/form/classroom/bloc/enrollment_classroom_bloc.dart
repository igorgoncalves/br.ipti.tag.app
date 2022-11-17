import 'package:br_ipti_tag_app/app/core/util/util.dart';
import 'package:br_ipti_tag_app/app/features/student/enrollment/bloc/enrollment_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tag_sdk/tag_sdk.dart';

import 'enrollment_classroom_states.dart';

class EnrollmentClassroomBloc extends Cubit<EnrollmentClassroomState> {
  EnrollmentClassroomBloc(
    this._listClassroomsUsecase,
    this._createStudentEnrollmentUsecase,
    this._updateStudentEnrollmentUsecase,
  ) : super(
          const EmptyEnrollmentClassroomState(),
        );

  final ListClassroomsUsecase _listClassroomsUsecase;
  final CreateStudentEnrollmentUsecase _createStudentEnrollmentUsecase;
  final UpdateStudentEnrollmentUsecase _updateStudentEnrollmentUsecase;
  final _session = Modular.get<SessionBloc>();
  final _enrollmentBloc = Modular.get<EnrollmentBloc>();

  // Turma
  void setStudentClass(int? classroomid) => emit(
        state.copyWith(
          classroomId: classroomid,
        ),
      );

  void setCurrentStageSituation(CurrentStageSituation? currentStageSituation) =>
      emit(
        state.copyWith(currentStageSituation: currentStageSituation),
      );

  void setPreviousStageSituation(PreviousStageSituation? previousStage) => emit(
        state.copyWith(previousStageSituation: previousStage),
      );

  void setStage(Stage? stage) => emit(
        state.copyWith(stage: stage),
      );

  void setAdmissionType(AdmissionType? admissionType) => emit(
        state.copyWith(studentEntryForm: admissionType),
      );

  void setSchoolAdmissionDate(String? schoolAdmissionDate) => emit(
        state.copyWith(schoolAdmissionDate: schoolAdmissionDate),
      );

  void setUnifiedClass(UnifiedClass? unifiedClass) => emit(
        state.copyWith(unifiedClass: unifiedClass),
      );

  void loadStudentEnrollment(StudentEnrollment studentEnrollment) {
    emit(
      state.copyWith(
        studentEnrollment: studentEnrollment,
        classroomId: studentEnrollment.classroomFk,
        anotherScholarizationPlace:
            studentEnrollment.anotherScholarizationPlace,
        currentStageSituation: CurrentStageSituation.values.byId(
          studentEnrollment.currentStageSituation,
        ),
        edcensoStageVsModalityFk: studentEnrollment.edcensoStageVsModalityFk,
        // stage: Stage.values.byId(studentEnrollment.stage),
        status: studentEnrollment.status,
        unifiedClass: UnifiedClass.values.byId(studentEnrollment.unifiedClass),
        schoolAdmissionDate: studentEnrollment.schoolAdmissionDate,
        studentEntryForm: AdmissionType.values.byId(
          studentEnrollment.studentEntryForm,
        ),
        previousStageSituation: PreviousStageSituation.values.byId(
          studentEnrollment.previousStageSituation,
        ),
      ),
    );
  }

  Future fetchClassrooms() async {
    final schoolId = _session.state.currentSchool?.inepId;
    final params = ClassroomParams(schoolId: schoolId);
    final result = await _listClassroomsUsecase(params);
    result.fold(
      id,
      (classrooms) => emit(
        state.copyWith(
          classrooms: classrooms,
        ),
      ),
    );
  }

  Future submit(EditMode mode) async {
    final _enrollmentBloc = Modular.get<EnrollmentBloc>();

    final schoolId = _session.state.currentSchool!.inepId;
    final studentId = _enrollmentBloc.student!.id!;

    switch (mode) {
      case EditMode.Create:
        final enrollment = StudentEnrollment(
          schoolInepIdFk: schoolId,
          studentFk: studentId,
          classroomFk: state.classroomId!,
          currentStageSituation: state.currentStageSituation?.id,
          previousStageSituation: state.previousStageSituation?.id,
          schoolAdmissionDate: state.schoolAdmissionDate,
          studentEntryForm: state.studentEntryForm?.id,
          unifiedClass: state.unifiedClass?.id,
          registerType: "rg",
        );
        await _create(enrollment);
        break;
      case EditMode.Edit:
        final oldStudentEnrollment = state.studentEnrollment;

        if (oldStudentEnrollment == null) return submit(EditMode.Create);

        final enrollment = oldStudentEnrollment.copyWith(
          schoolInepIdFk: schoolId,
          studentFk: studentId,
          classroomFk: state.classroomId,
          currentStageSituation: state.currentStageSituation?.id,
          previousStageSituation: state.previousStageSituation?.id,
          schoolAdmissionDate: state.schoolAdmissionDate,
          studentEntryForm: state.studentEntryForm?.id,
          unifiedClass: state.unifiedClass?.id,
          registerType: "rg",
        );
        await _update(enrollment.id!, enrollment);
        break;
    }
  }

  Future _create(StudentEnrollment enrollment) async {
    final params = CreateStudentEnrollmentParams(
      enrollment: enrollment,
    );

    final result = await _createStudentEnrollmentUsecase(params);

    result.fold(
      (error) => _enrollmentBloc.notifyError(
        error.toString(),
      ),
      (studentEnrollment) {
        _enrollmentBloc.loadStudentsEnrollment(studentEnrollment);
        _enrollmentBloc.notifySuccess(
          "Matricula realizadas com sucesso",
        );
      },
    );
  }

  Future _update(int id, StudentEnrollment enrollment) async {
    final params = UpdateStudentEnrollmentParams(
      enrollmentId: id,
      enrollment: enrollment,
    );

    final result = await _updateStudentEnrollmentUsecase(params);

    result.fold(
      (error) => _enrollmentBloc.notifyError(
        error.toString(),
      ),
      (studentEnrollment) {
        _enrollmentBloc.loadStudentsEnrollment(studentEnrollment);
        _enrollmentBloc.notifySuccess(
          "Matricula atualizada com sucesso",
        );
      },
    );
  }
}
