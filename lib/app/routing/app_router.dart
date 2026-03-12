import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/bloc/auth_bloc.dart';
import '../../modules/auth/presentation/screens/login_screen.dart';
import '../../modules/auth/presentation/screens/register_screen.dart';
import '../../modules/auth/presentation/screens/reset_password_screen.dart';
import '../../modules/expense/presentation/expense_list/bloc/expense_list_bloc.dart';
import '../../modules/expense/presentation/expense_list/screen/expense_list_screen.dart';
import '../../modules/expense/presentation/expense_form/bloc/expense_bloc.dart';
import '../../modules/expense/presentation/expense_form/config/form_config_builder.dart';
import '../../modules/expense/presentation/expense_form/config/screen_mode.dart';
import '../../modules/expense/presentation/expense_form/screen/expense_screen.dart';
import '../../modules/expense/domain/strategies/create_expense_strategy.dart';
import '../../modules/expense/domain/strategies/update_expense_strategy.dart';
import '../../modules/expense/domain/strategies/no_submit_strategy.dart';
import '../../modules/expense/domain/strategies/submit_strategy.dart';
import '../navigation/bottom_nav_container.dart';
import '../../core/di/service_provider.dart';
import 'auth_notifier.dart';
import 'route_guard.dart';

GoRouter createAppRouter(AuthBloc authBloc) {
  final authNotifier = AuthNotifier(authBloc);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authNotifier,
    redirect: (context, state) => RouteGuard.onRedirect(
      authState: authNotifier.state,
      routerState: state,
    ),
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavContainer(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) {
              return BlocProvider(
                create: (_) => ExpenseListBloc(
                  getExpenses: ServiceProvider.getExpenses,
                  deleteExpense: ServiceProvider.deleteExpense,
                  runner: ServiceProvider.blocSafeRunner,
                )..add(const LoadExpenses()),
                child: const ExpenseListScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'expense_form/:mode',
                name: 'expense_form',
                builder: (context, state) {
                  final modeStr = state.pathParameters['mode']!;
                  final mode = ScreenMode.values.byName(modeStr);
                  final id = state.uri.queryParameters['id'];

                  final SubmitStrategy strategy = switch (mode) {
                    ScreenMode.create =>
                      CreateExpenseStrategy(ServiceProvider.addExpense),
                    ScreenMode.edit =>
                      UpdateExpenseStrategy(ServiceProvider.updateExpense),
                    _ => const NoSubmitStrategy(),
                  };

                  return BlocProvider(
                    create: (_) => ExpenseBloc(
                      mode: mode,
                      getExpense: ServiceProvider.getExpense,
                      deleteExpense: ServiceProvider.deleteExpense,
                      submitStrategy: strategy,
                      formConfigBuilder: const FormConfigBuilder(),
                      runner: ServiceProvider.blocSafeRunner,
                    ),
                    child: ExpenseScreen(mode: mode, expenseId: id),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/analytics',
            name: 'analytics',
            builder: (context, state) => const AnalyticsScreen(),
            routes: [],
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [],
          ),
        ],
      ),
    ],
  );
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Analytics Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
