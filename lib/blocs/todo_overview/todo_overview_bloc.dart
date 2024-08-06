import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_appp/core/use_case.dart';

import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_collections.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvent, TodoOverviewState> {
  final LoadTodoCollections loadTodoCollections;

  TodoOverviewBloc({
    required this.loadTodoCollections,
  }) : super(TodoOverviewState.initial()) {
    on<ReadTodoOverviewEvent>((event, emit) async {
      emit(state.copyWith(todoOverViewStatus: TodoOverViewStatus.loading));

      try {
        final collectionsFuture = loadTodoCollections.call(NoParams());
        final collections = await collectionsFuture;

        if (collections.isLeft) {
          emit(state.copyWith(todoOverViewStatus: TodoOverViewStatus.error));
        } else {
          emit(state.copyWith(
              collections: collections.right,
              todoOverViewStatus: TodoOverViewStatus.loaded));
        }
      } on Exception {
        emit(state.copyWith(todoOverViewStatus: TodoOverViewStatus.error));
      }
    });
  }
}
