import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_appp/application/core/page_config.dart';
import 'package:todo_clean_appp/application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_clean_appp/application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_clean_appp/application/pages/overview/view_states/todo_overview_loading.dart';
import 'package:todo_clean_appp/blocs/todo_overview/todo_overview_bloc.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_collections.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TodoOverviewBloc(
          loadTodoCollections: LoadTodoCollections(
              todoRepository: RepositoryProvider.of(context)),
        )..add(ReadTodoOverviewEvent());
      },
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  static final pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    name: 'overview',
    child: const OverviewPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.tealAccent,
        child: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
          builder: (context, state) {
            if (state.todoOverViewStatus == TodoOverViewStatus.loading) {
              return const TodoOverviewLoading();
            } else if (state.todoOverViewStatus == TodoOverViewStatus.error &&
                state.collections.isEmpty) {
              return const TodoOverviewError();
            }

            return TodoOverviewLoaded(collections: state.collections);
          },
        ));
  }
}
