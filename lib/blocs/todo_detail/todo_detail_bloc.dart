import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_appp/core/use_case.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_entry_ids_for_collection.dart';

part 'todo_detail_event.dart';
part 'todo_detail_state.dart';

class TodoDetailBloc extends Bloc<TodoDetailEvent, TodoDetailState> {
  TodoDetailBloc() : super(TodoDetailState.initial()) {
    on<ReadTodoDetailEvent>((event, emit) async {
      emit(state.copyWith(status: TodoDetailStatus.loading));

      try {
        final entryIds = await event.loadTodoEntryIdsForCollection
            .call(CollectionIdParam(collectionId: event.collectionId));

        if (entryIds.isLeft) {
          emit(state.copyWith(status: TodoDetailStatus.error));
        } else {
          emit(
            state.copyWith(
                status: TodoDetailStatus.loaded, entryId: entryIds.right),
          );
        }
      } on Exception {
        emit(state.copyWith(status: TodoDetailStatus.error));
      }
    });
  }
}
