import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_clean_appp/application/core/go_router_observer.dart';
import 'package:todo_clean_appp/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_clean_appp/application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_clean_appp/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_clean_appp/application/pages/detail/todo_detail_page.dart';
import 'package:todo_clean_appp/application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:todo_clean_appp/application/pages/home/home_page.dart';
import 'package:todo_clean_appp/application/pages/overview/overview_page.dart';
import 'package:todo_clean_appp/application/pages/settings/settings_page.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';

final routers = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.params['tab'] ?? '',
          ),
        )
      ],
      builder: (context, state, child) => child,
    ),
    GoRoute(
      path: '$_basePath/overview/${CreateTodoCollectionPage.pageConfig.name}',
      name: CreateTodoCollectionPage.pageConfig.name,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('create collection'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(HomePage.pageConfig.name,
                    params: {'tab': OverviewPage.pageConfig.name});
              }
            },
          ),
        ),
        body: SafeArea(child: CreateTodoCollectionPage.pageConfig.child),
      ),
    ),
    GoRoute(
      path: '$_basePath/overview/${CreateTodoEntryPage.pageConfig.name}',
      name: CreateTodoEntryPage.pageConfig.name,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('create entry'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(HomePage.pageConfig.name,
                    params: {'tab': OverviewPage.pageConfig.name});
              }
            },
          ),
        ),
        body: SafeArea(
            child: CreateTodoEntryPageProvider(
          collectionId: state.extra as CollectionId,
        )),
      ),
    ),
    GoRoute(
      name: TodoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) =>
          BlocListener<NavigationTodoCubit, NavigationTodoState>(
        listenWhen: (previous, current) =>
            previous.secondBodyIsDisplayed != current.secondBodyIsDisplayed,
        listener: (context, state) {
          if (context.canPop() && (state.secondBodyIsDisplayed ?? false)) {
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('details'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.pageConfig.name,
                      params: {'tab': OverviewPage.pageConfig.name});
                }
              },
            ),
          ),
          body: TodoDetailPageProvider(
            collectionId: CollectionId.fromUniqueString(
                state.params['collectionId'] ?? ''),
          ),
        ),
      ),
    ),
  ],
);
