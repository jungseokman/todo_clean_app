import 'package:todo_clean_appp/domain/entities/todo_color.dart';
import 'package:todo_clean_appp/domain/entities/todo_entry.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/failures/failures.dart';
import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:either_dart/either.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<TodoEntry> todoEntries = List.generate(
    100,
    (index) => TodoEntry(
      desc: 'desc : $index',
      isDone: false,
      id: EntryId.fromUniqueString(index.toString()),
    ),
  );

  final todoCollections = List<TodoCollection>.generate(
    10,
    (index) => TodoCollection(
      title: 'title $index',
      color: TodoColor(colorIndex: index % TodoColor.predefinedColors.length),
      id: CollectionId.fromUniqueString(index.toString()),
    ),
  );

  @override
  Future<Either<Failure, List<TodoCollection>>> readTodoCollection() {
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => Right(todoCollections),
    );
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem =
          todoEntries.firstWhere((element) => element.id == entryId);

      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(selectedEntryItem));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds =
          todoEntries.sublist(startIndex, endIndex).map((e) => e.id).toList();
      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId}) {
    final index = todoEntries.indexWhere((element) {
      return element.id == entryId;
    });

    final updatedEntry =
        todoEntries[index].copyWith(isDone: !todoEntries[index].isDone);

    todoEntries[index] = updatedEntry;

    return Future.delayed(
      const Duration(milliseconds: 100),
      () => Right(updatedEntry),
    );
  }

  @override
  Future<Either<Failure, bool>> createTodoCollection(
      TodoCollection collection) {
    todoCollections.add(collection);
    return Future.delayed(
        const Duration(milliseconds: 100), () => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(TodoEntry entry) {
    todoEntries.add(entry);
    return Future.delayed(
        const Duration(milliseconds: 150), () => const Right(true));
  }
}
