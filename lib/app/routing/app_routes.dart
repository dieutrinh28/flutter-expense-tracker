enum AppRoutes {
  login('login'),
  register('register'),
  resetPassword('reset-password'),
  home('home'),
  analytics('analytics'),
  settings('settings'),
  expenseForm('expense_form');

  const AppRoutes(this.path);
  final String path;
}
