import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_provider.dart';
import 'core/theme/app_theme.dart';
import 'app/routing/app_router.dart';
import 'modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.initialize();
  runApp(BlocProvider(
    create: (context) => AuthBloc(
      loginUseCase: ServiceProvider.loginUseCase,
      logoutUseCase: ServiceProvider.logoutUseCase,
      checkAuthUseCase: ServiceProvider.checkAuthUseCase,
      runner: ServiceProvider.blocSafeRunner,
    )..add(const CheckAuthEvent()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme(),
      routerConfig: appRouter,
    );
  }
}
