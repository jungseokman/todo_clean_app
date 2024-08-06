import 'package:either_dart/either.dart';

import 'package:todo_clean_appp/core/use_case.dart';
import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:todo_clean_appp/domain/failures/failures.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';

class LoadTodoCollections implements UseCase<List<TodoCollection>, NoParams> {
  final TodoRepository todoRepository;
  LoadTodoCollections({
    required this.todoRepository,
  });

  @override
  Future<Either<Failure, List<TodoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = todoRepository.readTodoCollection();

      return loadedCollections.fold(
          (left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
