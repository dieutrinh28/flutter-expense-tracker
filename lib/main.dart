import 'package:flutter/material.dart';
import 'core/di/service_provider.dart';
import 'core/theme/app_theme.dart';
import 'app/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.initialize();
  runApp(const MyApp());
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
