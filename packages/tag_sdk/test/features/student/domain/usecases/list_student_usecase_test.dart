import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tag_sdk/src/core/failures/failures.dart';
import 'package:tag_sdk/tag_sdk.dart';

class MockStudentRepository extends Mock implements StudentRepository {}

void main() {
  testWidgets(
    "ListStudentUsecase when returns a right empty value",
    (tester) async {
      final repository = MockStudentRepository();

      when(
        () => repository.listAll(schoolId: ''),
      ).thenAnswer(
        (realInvocation) => Future.value(
          right([]),
        ),
      );

      final usecase = ListStudentsUsecase(repository);
      final params = ListStudentsParams('');

      final either = await usecase(params);

      expect(either.isRight(), isTrue);

      final result = either.fold(id, id);
      expect(result, isEmpty);
    },
  );

  testWidgets(
    "ListStudentUsecase when returns a left ConnexionExpection",
    (tester) async {
      final repository = MockStudentRepository();

      when(
        () => repository.listAll(schoolId: ''),
      ).thenAnswer(
        (realInvocation) => Future.value(left(
          const RestFailure("Conexão invalida"),
        )),
      );

      final usecase = ListStudentsUsecase(repository);
      final params = ListStudentsParams('');

      final either = await usecase(params);

      expect(either.isLeft(), isTrue);

      final result = either.fold(id, id);

      expect(
        result,
        isA<RestFailure>(),
      );
    },
  );
}
