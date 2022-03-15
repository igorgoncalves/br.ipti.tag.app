import 'package:br_ipti_tag_app/app/core/usecases/usecase.dart';
import 'package:br_ipti_tag_app/app/features/student/domain/entities/student_documents.dart';
import 'package:br_ipti_tag_app/app/features/student/domain/repositories/student_doc_address_repositories.dart';

import 'package:dartz/dartz.dart';

class LoadStudentDocsUsecase
    implements Usecase<StudentDocuments, LoadStudentDocsParams> {
  LoadStudentDocsUsecase(this._repositoryStudentDocs);

  final StudentDocumentsAddressRepository _repositoryStudentDocs;

  @override
  Future<Either<Exception, StudentDocuments>> call(
    LoadStudentDocsParams params,
  ) async {
    final result = await _repositoryStudentDocs.getByStudentId(
      params.studentId,
    );

    return result;
  }
}

class LoadStudentDocsParams {
  final String studentId;
  final String schoolId;

  LoadStudentDocsParams(this.studentId, this.schoolId);
}
