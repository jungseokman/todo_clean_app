import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_clean_appp/application/core/page_config.dart';
import 'package:todo_clean_appp/application/pages/detail/view_states/todo_detail_error.dart';
import 'package:todo_clean_appp/application/pages/detail/view_states/todo_detail_loaded.dart';
import 'package:todo_clean_appp/application/pages/detail/view_states/todo_detail_loading.dart';
import 'package:todo_clean_appp/blocs/todo_detail/todo_detail_bloc.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_entry_ids_for_collection.dart';

class TodoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;
  const TodoDetailPageProvider({
    Key? key,
    required this.collectionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDetailBloc>(
      create: (context) => TodoDetailBloc()
        ..add(
          ReadTodoDetailEvent(
            collectionId: collectionId,
            loadTodoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
              todoRepository: RepositoryProvider.of<TodoRepository>(context),
            ),
          ),
        ),
      child: TodoDetailPage(collectionId: collectionId),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  final CollectionId collectionId;

  const TodoDetailPage({
    Key? key,
    required this.collectionId,
  }) : super(key: key);

  static final pageConfig = PageConfig(
    icon: Icons.details_rounded,
    name: 'detail',
    child: const Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailBloc, TodoDetailState>(
      builder: (context, state) {
        if (state.status == TodoDetailStatus.loading) {
          return const TodoDetailLoading();
        }

        if (state.status == TodoDetailStatus.error) {
          return const TodoDetailError();
        }

        return TodoDetailLoaded(
            entryIds: state.entryId, collectionId: collectionId);
      },
    );
  }
}
