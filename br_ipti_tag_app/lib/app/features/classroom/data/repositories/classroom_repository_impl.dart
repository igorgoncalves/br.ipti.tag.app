import 'package:br_ipti_tag_app/app/core/network/interceptors/error_interceptor.dart';
import 'package:br_ipti_tag_app/app/features/classroom/data/datasource/classroom_datasource.dart';
import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/classroom_create_entity.dart';
import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/classroom_entity.dart';
import 'package:br_ipti_tag_app/app/features/classroom/domain/repositories/classroom_repository.dart';
import 'package:dartz/dartz.dart';

class ClassroomRepositoryImpl extends ClassroomRepository {
  final ClassroomRemoteDataSource classroomRemoteDataSource;

  ClassroomRepositoryImpl({required this.classroomRemoteDataSource});

  @override
  Future<Either<Exception, bool>> create(
    ClassroomCreateEntity classroom,
  ) async {
    try {
      final result = await classroomRemoteDataSource.create(
        classroom.fromEntity(),
      );
      return Right(result);
    } on RestClientException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<ClassroomEntity>>> list() async {
    try {
      final result = await classroomRemoteDataSource.listAll();
      return Right(result);
    } on RestClientException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> delete({required String id}) async {
    try {
      final result = await classroomRemoteDataSource.delete(id);
      return Right(result);
    } on RestClientException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> update({
    required String id,
    required ClassroomCreateEntity classroomCreateEntity,
  }) async {
    try {
      final result = await classroomRemoteDataSource.update(
        classroomCreateEntity.fromEntity(),
        id,
      );
      return Right(result);
    } on RestClientException catch (e) {
      return Left(e);
    }
  }
}
