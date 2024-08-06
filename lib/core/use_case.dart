import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:todo_clean_appp/domain/entities/todo_entry.dart';

import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class TodoEntryIdsParam extends Params {
  final EntryId entryId;
  final CollectionId collectionId;
  TodoEntryIdsParam({
    required this.entryId,
    required this.collectionId,
  });

  @override
  List<Object> get props => [entryId, collectionId];
}

class CollectionIdParam extends Params {
  final CollectionId collectionId;
  CollectionIdParam({
    required this.collectionId,
  });

  @override
  List<Object> get props => [collectionId];
}

class TodoCollectionParams extends Params {
  final TodoCollection collection;
  TodoCollectionParams({
    required this.collection,
  });

  @override
  List<Object> get props => [collection];
}

class TodoEntryParams extends Params {
  final TodoEntry entry;
  TodoEntryParams({
    required this.entry,
  });

  @override
  List<Object> get props => [entry];
}
