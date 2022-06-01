import 'package:br_ipti_tag_app/app/core/usecases/usecase.dart';
import 'package:br_ipti_tag_app/app/features/teacher/domain/entities/instructor.dart';
import 'package:br_ipti_tag_app/app/features/teacher/domain/repositories/instructor_repository.dart';

import 'package:dartz/dartz.dart';

class CreateInstructorsUsecase
    implements Usecase<Instructor, CreateInstructorParams> {
  CreateInstructorsUsecase(this._repositoryInstructor);

  final InstructorRepository _repositoryInstructor;

  @override
  Future<Either<Exception, Instructor>> call(
    CreateInstructorParams params,
  ) async {
    final instructor = Instructor();

    final result = await _repositoryInstructor.create(instructor);
    return result;
  }
}

class CreateInstructorParams {
  String? neighborhood;
  String? complement;
  String? addressNumber;
  String? address;
  String? cep;
  String? diffLocation;
  int? areaOfResidence;
  String? cpf;
  bool otherCoursesNone = false;
  bool otherCoursesOther = false;
  bool otherCoursesEthnicEducation = false;
  bool otherCoursesChildAndTeenageRights = false;
  bool otherCoursesSexualEducation = false;
  bool otherCoursesHumanRightsEducation = false;
  bool otherCoursesEnvironmentEducation = false;
  bool otherCoursesFieldEducation = false;
  bool otherCoursesNativeEducation = false;
  bool otherCoursesSpecialEducation = false;
  bool otherCoursesEducationOfYouthAndAdults = false;
  bool otherCoursesHighSchool = false;
  bool otherCoursesBasicEducationFinalYears = false;
  bool otherCoursesBasicEducationInitialYears = false;
  bool otherCoursesPreSchool = false;
  bool otherCoursesNursery = false;
  bool postGraduationNone = false;
  bool postGraduationDoctorate = false;
  bool postGraduationMaster = false;
  bool postGraduationSpecialization = false;
  bool highEducationInstitutionCode3Fk = false;
  bool highEducationFinalYear3 = false;
  bool highEducationInitialYear3 = false;
  bool highEducationCourseCode3Fk = false;
  bool highEducationFormation3 = false;
  bool highEducationSituation3 = false;
  bool highEducationInstitutionCode2Fk = false;
  bool highEducationFinalYear2 = false;
  bool highEducationInitialYear2 = false;
  bool highEducationCourseCode2Fk = false;
  bool highEducationFormation2 = false;
  bool highEducationSituation2 = false;
  bool highEducationInstitutionCode1Fk = false;
  bool highEducationFinalYear1 = false;
  bool highEducationInitialYear1 = false;
  bool highEducationCourseCode1Fk = false;
  bool highEducationFormation1 = false;
  bool highEducationSituation1 = false;
  String? hash;
  bool deficiencyTypeGifted = false;
  bool deficiencyTypeAutism = false;
  bool deficiencyTypeMultipleDisabilities = false;
  bool deficiencyTypeIntelectualDisability = false;
  bool deficiencyTypePhisicalDisability = false;
  bool deficiencyTypeDeafblindness = false;
  bool deficiencyTypeDisabilityHearing = false;
  bool deficiencyTypeDeafness = false;
  bool deficiencyTypeLowVision = false;
  bool deficiencyTypeBlindness = false;
  String? filiation2;
  String? filiation1;
  int? filiation;
  String? nis;
  String? email;
  String? inepId;
  String registerType;
  String? id;
  String schoolInepIdFk;
  String name;
  String birthdayDate;
  int sex;
  int colorRace;
  int nationality;
  String edcensoNationFk;
  String edcensoUfFk;
  String edcensoCityFk;
  bool deficiency = false;
  int scholarity;

  CreateInstructorParams({
    this.neighborhood,
    this.complement,
    this.addressNumber,
    this.address,
    this.cep,
    this.diffLocation,
    this.areaOfResidence,
    this.cpf,
    this.otherCoursesNone = false,
    this.otherCoursesOther = false,
    this.otherCoursesEthnicEducation = false,
    this.otherCoursesChildAndTeenageRights = false,
    this.otherCoursesSexualEducation = false,
    this.otherCoursesHumanRightsEducation = false,
    this.otherCoursesEnvironmentEducation = false,
    this.otherCoursesFieldEducation = false,
    this.otherCoursesNativeEducation = false,
    this.otherCoursesSpecialEducation = false,
    this.otherCoursesEducationOfYouthAndAdults = false,
    this.otherCoursesHighSchool = false,
    this.otherCoursesBasicEducationFinalYears = false,
    this.otherCoursesBasicEducationInitialYears = false,
    this.otherCoursesPreSchool = false,
    this.otherCoursesNursery = false,
    this.postGraduationNone = false,
    this.postGraduationDoctorate = false,
    this.postGraduationMaster = false,
    this.postGraduationSpecialization = false,
    this.highEducationInstitutionCode3Fk = false,
    this.highEducationFinalYear3 = false,
    this.highEducationInitialYear3 = false,
    this.highEducationCourseCode3Fk = false,
    this.highEducationFormation3 = false,
    this.highEducationSituation3 = false,
    this.highEducationInstitutionCode2Fk = false,
    this.highEducationFinalYear2 = false,
    this.highEducationInitialYear2 = false,
    this.highEducationCourseCode2Fk = false,
    this.highEducationFormation2 = false,
    this.highEducationSituation2 = false,
    this.highEducationInstitutionCode1Fk = false,
    this.highEducationFinalYear1 = false,
    this.highEducationInitialYear1 = false,
    this.highEducationCourseCode1Fk = false,
    this.highEducationFormation1 = false,
    this.highEducationSituation1 = false,
    this.hash,
    this.deficiencyTypeGifted = false,
    this.deficiencyTypeAutism = false,
    this.deficiencyTypeMultipleDisabilities = false,
    this.deficiencyTypeIntelectualDisability = false,
    this.deficiencyTypePhisicalDisability = false,
    this.deficiencyTypeDeafblindness = false,
    this.deficiencyTypeDisabilityHearing = false,
    this.deficiencyTypeDeafness = false,
    this.deficiencyTypeLowVision = false,
    this.deficiencyTypeBlindness = false,
    this.filiation2,
    this.filiation1,
    this.filiation,
    this.nis,
    this.email,
    this.inepId,
    required this.registerType,
    this.id,
    required this.schoolInepIdFk,
    required this.name,
    required this.birthdayDate,
    required this.sex,
    required this.colorRace,
    required this.nationality,
    required this.edcensoNationFk,
    required this.edcensoUfFk,
    required this.edcensoCityFk,
    this.deficiency = false,
    required this.scholarity,
  });
}
