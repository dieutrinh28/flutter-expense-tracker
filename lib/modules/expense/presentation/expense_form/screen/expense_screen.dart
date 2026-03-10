import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_bloc.dart';
import '../config/form_config.dart';
import '../config/screen_mode.dart';
import '../models/expense_form_data.dart';
import '../widgets/expense_action_bar.dart';
import '../widgets/expense_form.dart';
import '../widgets/expense_header.dart';

class ExpenseScreen extends StatelessWidget {
  final ScreenMode mode;
  final String? expenseId;

  const ExpenseScreen({
    super.key,
    required this.mode,
    this.expenseId,
  });

  @override
  Widget build(BuildContext context) {
    return _ExpenseScreenBody(
      mode: mode,
      expenseId: expenseId,
    );
  }
}

class _ExpenseScreenBody extends StatefulWidget {
  final ScreenMode mode;
  final String? expenseId;

  const _ExpenseScreenBody({
    super.key,
    required this.mode,
    this.expenseId,
  });

  @override
  State<_ExpenseScreenBody> createState() => _ExpenseScreenBodyState();
}

class _ExpenseScreenBodyState extends State<_ExpenseScreenBody> {
  late final StreamSubscription _effectSub;

  @override
  void initState() {
    super.initState();
    _effectSub = context.read<ExpenseBloc>().effects.listen(_handleEffect);

    if (widget.mode != ScreenMode.create && widget.expenseId != null) {
      context.read<ExpenseBloc>().add(LoadExpense(id: widget.expenseId!));
    }
  }

  void _handleEffect(ExpenseEffect effect) {
    if (!mounted) return;
    switch (effect) {
      case NavigateBack():
        Navigator.of(context).pop();
      case NavigateToEdit(:final expenseId):
        // Navigate to edit screen or update current bloc state if preferred.
        // For simplicity, we just push a new edit screen.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpenseScreen(
              mode: ScreenMode.edit,
              expenseId: expenseId,
            ),
          ),
        );
      case ShowSuccessToast(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      case ShowErrorDialog(:final title, :final body):
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      case ShowDeleteConfirmation(:final expenseId):
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Expense'),
            content: const Text('Are you sure you want to delete this expense?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<ExpenseBloc>().add(ConfirmDeleteExpense(id: expenseId));
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
    }
  }

  @override
  void dispose() {
    _effectSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensure white background as per mockup
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) => switch (state) {
            ExpenseInitial() => const _LoadingView(),
            ExpenseLoading() => const _LoadingView(),
            ExpenseSaved() => const _LoadingView(),
            ExpenseLoaded(:final formData, :final formConfig) => _ContentView(
                mode: widget.mode,
                formData: formData,
                formConfig: formConfig,
                isSaving: false,
              ),
            ExpenseEditing(
              :final formData,
              :final formConfig,
              :final validationErrors
            ) =>
              _ContentView(
                mode: widget.mode,
                formData: formData,
                formConfig: formConfig,
                isSaving: false,
                validationErrors: validationErrors,
              ),
            ExpenseSaving(:final formData) => _ContentView(
                mode: widget.mode,
                formData: formData,
                formConfig: context.read<ExpenseBloc>().formConfig,
                isSaving: true,
              ),
            ExpenseError(:final message) => _ErrorView(message: message),
          },
        ),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  final ScreenMode mode;
  final ExpenseFormData formData;
  final FormConfig formConfig;
  final bool isSaving;
  final Map<String, String> validationErrors;

  const _ContentView({
    required this.mode,
    required this.formData,
    required this.formConfig,
    required this.isSaving,
    this.validationErrors = const {},
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExpenseBloc>();

    return Column(
      children: [
        ExpenseHeader(
          mode: mode,
          onBack: () => Navigator.of(context).pop(),
          onClose: () => Navigator.of(context).pop(),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ExpenseForm(
              formConfig: formConfig,
              formData: formData,
              onFieldChanged: (key, value) {
                bloc.add(FieldChanged(key: key, value: value));
              },
              validationErrors: validationErrors,
            ),
          ),
        ),
        if (formConfig.showActionBar)
          ExpenseActionBar(
            mode: mode,
            isSaving: isSaving,
            onSave: () => bloc.add(const SubmitExpense()),
            onEdit: () => bloc.add(const EditTapped()),
            onDelete: () {
              if (formData.id != null) {
                bloc.add(DeleteExpenseRequested(id: formData.id!));
              }
            },
          ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator.adaptive());
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text(message),
          ],
        ),
      );
}
