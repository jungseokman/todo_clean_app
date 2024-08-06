part of 'todo_detail_bloc.dart';

abstract class TodoDetailEvent extends Equatable {
  const TodoDetailEvent();

  @override
  List<Object> get props => [];
}

class ReadTodoDetailEvent extends TodoDetailEvent {
  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;
  const ReadTodoDetailEvent({
    required this.collectionId,
    required this.loadTodoEntryIdsForCollection,
  });

  @override
  List<Object> get props => [collectionId, loadTodoEntryIdsForCollection];
}
