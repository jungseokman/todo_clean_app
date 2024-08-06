import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_clean_appp/application/core/page_config.dart';
import 'package:todo_clean_appp/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_clean_appp/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_clean_appp/application/pages/detail/todo_detail_page.dart';
import 'package:todo_clean_appp/application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:todo_clean_appp/application/pages/overview/overview_page.dart';
import 'package:todo_clean_appp/application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  static final PageConfig pageConfig =
      PageConfig(icon: Icons.home_rounded, name: 'home');

  static final tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) => NavigationDestination(
          icon: Icon(page.icon),
          label: page.name,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  leading: IconButton(
                      key: const Key('create-todo-collection'),
                      onPressed: () {
                        context.pushNamed(
                            CreateTodoCollectionPage.pageConfig.name);
                      },
                      icon: Icon(CreateTodoCollectionPage.pageConfig.icon),
                      tooltip: 'Add Collection'),
                  trailing: IconButton(
                      onPressed: () =>
                          context.goNamed(SettingsPage.pageConfig.name),
                      icon: Icon(SettingsPage.pageConfig.icon)),
                  selectedLabelTextStyle:
                      TextStyle(color: theme.colorScheme.onBackground),
                  selectedIconTheme:
                      IconThemeData(color: theme.colorScheme.onBackground),
                  unselectedIconTheme: IconThemeData(
                      color: theme.colorScheme.onBackground.withOpacity(0.5)),
                  onDestinationSelected: (index) =>
                      _topOnNavigationDestination(context, index),
                  destinations: destinations
                      .map((_) => AdaptiveScaffold.toRailDestination(_))
                      .toList(),
                  selectedIndex: widget.index,
                ),
              )
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-navigation-small'),
                builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                  currentIndex: widget.index,
                  onDestinationSelected: (index) =>
                      _topOnNavigationDestination(context, index),
                ),
              )
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body-samll'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body-medium'),
              builder: widget.index != 1
                  ? null
                  : (_) =>
                      BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
                        builder: (context, state) {
                          final selectedId = state.selectedCollectionId;
                          final isSecondBodyDisplayed =
                              Breakpoints.mediumAndUp.isActive(context);
                          context
                              .read<NavigationTodoCubit>()
                              .secondBodyHasChanged(
                                  isSecondBodyDisplayed: isSecondBodyDisplayed);
                          if (selectedId == null) return const Placeholder();
                          return TodoDetailPageProvider(
                              key: Key(selectedId.value),
                              collectionId: selectedId);
                        },
                      ),
            )
          }),
        ),
      ),
    );
  }

  void _topOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(
        HomePage.pageConfig.name,
        params: {
          'tab': HomePage.tabs[index].name,
        },
      );
}
