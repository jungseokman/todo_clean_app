import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_appp/core/use_case.dart';
import 'package:todo_clean_appp/domain/entities/todo_entry.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_entry.dart';
import 'package:todo_clean_appp/domain/use_cases/update_todo_entry.dart';

part 'todo_entry_item_event.dart';
part 'todo_entry_item_state.dart';

class TodoEntryItemBloc extends Bloc<TodoEntryItemEvent, TodoEntryItemState> {
  TodoEntryItemBloc() : super(TodoEntryItemState.intial()) {
    on<ReadTodoEntryItemEvent>((event, emit) {
      emit(state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.loading));

      try {
        final entry = event.loadTodoEntry.call(TodoEntryIdsParam(
            entryId: event.entryId, collectionId: event.collectionId));

        return entry.fold(
            (left) => emit(
                state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.error)),
            (right) => emit(state.copyWith(
                todoEntry: right,
                todoEntryItemStatus: TodoEntryItemStatus.loaded)));
      } on Exception {
        emit(state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.error));
      }
    });

    on<UpdateTodoEntryItemEvent>((event, emit) async {
      emit(state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.loading));
      try {
        final updateEntry = await event.updateTodoEntry.call(TodoEntryIdsParam(
            entryId: event.entryId, collectionId: event.collectionId));

        return updateEntry.fold(
            (left) => emit(
                state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.error)),
            (right) {
          return emit(state.copyWith(
              todoEntry: right,
              todoEntryItemStatus: TodoEntryItemStatus.loaded));
        });
        // final updateEntry = state.todoEntry.copyWith(
        //   isDone: !state.todoEntry.isDone,
        // );

        // emit(state.copyWith(
        //     todoEntry: updateEntry,
        //     todoEntryItemStatus: TodoEntryItemStatus.loaded));
      } on Exception {
        emit(state.copyWith(todoEntryItemStatus: TodoEntryItemStatus.error));
      }
    });
  }
}
