import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_clean_appp/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_clean_appp/application/pages/detail/todo_detail_page.dart';
import 'package:todo_clean_appp/application/pages/home/cubit/navigation_todo_cubit.dart';

import 'package:todo_clean_appp/domain/entities/todo_collection.dart';

class TodoOverviewLoaded extends StatelessWidget {
  const TodoOverviewLoaded({
    Key? key,
    required this.collections,
  }) : super(key: key);

  final List<TodoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemBuilder: (context, index) {
            final item = collections[index];
            final colorScheme = Theme.of(context).colorScheme;

            return BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
              buildWhen: (previous, current) =>
                  previous.selectedCollectionId != current.selectedCollectionId,
              builder: (context, state) {
                return ListTile(
                  tileColor: colorScheme.surface,
                  selectedTileColor: colorScheme.surfaceVariant,
                  iconColor: item.color.color,
                  selectedColor: item.color.color,
                  selected: state.selectedCollectionId == item.id,
                  onTap: () {
                    if (Breakpoints.small.isActive(context)) {
                      context.pushNamed(TodoDetailPage.pageConfig.name,
                          params: {'collectionId': item.id.value});
                    }
                    context
                        .read<NavigationTodoCubit>()
                        .selectedTodoCollectionChanged(item.id);
                  },
                  leading: const Icon(Icons.circle),
                  title: Text(item.title),
                );
              },
            );
          },
          itemCount: collections.length,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-collection'),
              onPressed: () {
                context.pushNamed(CreateTodoCollectionPage.pageConfig.name);
              },
              child: Icon(CreateTodoCollectionPage.pageConfig.icon),
            ),
          ),
        )
      ],
    );
  }
}
