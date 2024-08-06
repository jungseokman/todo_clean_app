part of 'todo_entry_item_bloc.dart';

abstract class TodoEntryItemEvent extends Equatable {
  const TodoEntryItemEvent();

  @override
  List<Object> get props => [];
}

class ReadTodoEntryItemEvent extends TodoEntryItemEvent {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;
  const ReadTodoEntryItemEvent({
    required this.entryId,
    required this.collectionId,
    required this.loadTodoEntry,
  });
}

class UpdateTodoEntryItemEvent extends TodoEntryItemEvent {
  final EntryId entryId;
  final CollectionId collectionId;
  final UpdateTodoEntry updateTodoEntry;
  const UpdateTodoEntryItemEvent({
    required this.entryId,
    required this.collectionId,
    required this.updateTodoEntry,
  });
}
