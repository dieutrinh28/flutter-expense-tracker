import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/service_provider.dart';
import 'core/theme/app_theme.dart';
import 'app/routing/app_router.dart';
import 'modules/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.initialize();

  final authBloc = AuthBloc(
    loginUseCase: ServiceProvider.loginUseCase,
    registerUseCase: ServiceProvider.registerUseCase,
    resetPasswordUseCase: ServiceProvider.resetPasswordUseCase,
    logoutUseCase: ServiceProvider.logoutUseCase,
    checkAuthUseCase: ServiceProvider.checkAuthUseCase,
    runner: ServiceProvider.blocSafeRunner,
  )..add(const CheckAuthEvent());

  runApp(
    BlocProvider.value(
      value: authBloc,
      child: MyApp(router: createAppRouter(authBloc)),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme(),
      routerConfig: router,
    );
  }
}
