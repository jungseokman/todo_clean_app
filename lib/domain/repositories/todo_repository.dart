import 'package:either_dart/either.dart';
import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:todo_clean_appp/domain/entities/todo_entry.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/failures/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readTodoCollection();

  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId);

  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId});

  Future<Either<Failure, bool>> createTodoCollection(TodoCollection collection);

  Future<Either<Failure, bool>> createTodoEntry(TodoEntry entry);
}
