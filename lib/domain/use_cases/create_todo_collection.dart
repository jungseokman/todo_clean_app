import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:todo_clean_appp/core/use_case.dart';
import 'package:todo_clean_appp/domain/failures/failures.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';

class CreateTodoCollecion implements UseCase<bool, TodoCollectionParams> {
  final TodoRepository todoRepository;
  CreateTodoCollecion({
    required this.todoRepository,
  });

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result =
          await todoRepository.createTodoCollection(params.collection);

      return result.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
