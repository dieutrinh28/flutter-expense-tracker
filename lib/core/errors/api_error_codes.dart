class ApiErrorCode {
  ApiErrorCode._();

  // --- Expense ---
  static const expenseLimitExceeded = 'EXPENSE_LIMIT_EXCEEDED';
  static const duplicateExpense     = 'DUPLICATE_EXPENSE';
  static const expenseNotFound      = 'EXPENSE_NOT_FOUND';

  // --- Auth ---
  static const invalidCredentials   = 'INVALID_CREDENTIALS';
  static const accountLocked        = 'ACCOUNT_LOCKED';
  static const emailAlreadyExists   = 'EMAIL_ALREADY_EXISTS';

  // --- Budget ---
  static const budgetNotFound       = 'BUDGET_NOT_FOUND';
  static const budgetAlreadyExists  = 'BUDGET_ALREADY_EXISTS';
  static const budgetLimitExceeded  = 'BUDGET_LIMIT_EXCEEDED';

  // --- General ---
  static const rateLimitExceeded    = 'RATE_LIMIT_EXCEEDED';
  static const maintenanceMode      = 'MAINTENANCE_MODE';
}