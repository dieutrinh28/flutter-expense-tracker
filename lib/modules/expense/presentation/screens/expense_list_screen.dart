import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../blocs/expense_list_bloc/expense_list_bloc.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: BlocBuilder<ExpenseListBloc, ExpenseListState>(
        builder: (context, state) {
          if (state is ExpenseListLoading) {
            return const _LoadingState();
          }

          if (state is ExpenseListError) {
            return _ErrorState(message: state.message);
          }

          if (state is ExpenseListEmpty) {
            return const _EmptyState();
          }

          if (state is ExpenseListLoaded) {
            final totalAmount = state.expenses.fold<double>(
              0.0,
              (sum, expense) => sum + expense.amount,
            );
            return _LoadedState(
              expenses: state.expenses,
              totalAmount: totalAmount,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorPalette.blueLight10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.blueDark,
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Loading expenses...',
            style: AppTypography.body.copyWith(
              color: ColorPalette.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;

  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ColorPalette.redLight10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  size: 40,
                  color: ColorPalette.redDark,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Oops! Something went wrong',
              style: AppTypography.title.copyWith(
                color: ColorPalette.primaryText,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(
                color: ColorPalette.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: ColorPalette.purpleGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Icon(
                Icons.inbox_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No expenses yet',
            style: AppTypography.title.copyWith(
              color: ColorPalette.primaryText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Start tracking your expenses to see them here',
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              color: ColorPalette.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  final List expenses;
  final double totalAmount;

  const _LoadedState({
    required this.expenses,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Summary Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: _SummaryCard(
              totalAmount: totalAmount,
              expenseCount: expenses.length,
            ),
          ),
        ),
        // Expenses List
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final expense = expenses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: _ExpenseCard(expense: expense),
              );
            },
            childCount: expenses.length,
          ),
        ),
        // Bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.lg),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double totalAmount;
  final int expenseCount;

  const _SummaryCard({
    required this.totalAmount,
    required this.expenseCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorPalette.greenGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.greenDark15,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expenses',
              style: AppTypography.caption.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '\$${totalAmount.toStringAsFixed(2)}',
              style: AppTypography.title.copyWith(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              decoration: BoxDecoration(
                color: ColorPalette.white20,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                '$expenseCount ${expenseCount == 1 ? 'expense' : 'expenses'}',
                style: AppTypography.caption.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final dynamic expense;

  const _ExpenseCard({required this.expense});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = ColorPalette.getCategoryColor(expense.category);
    final categoryBgColor = ColorPalette.getCategoryLightColor(expense.category);

    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: ColorPalette.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.black04,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // Category Icon/Badge
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: categoryBgColor,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Center(
                child: _getCategoryIcon(expense.category, categoryColor),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Expense Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      color: ColorPalette.primaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      // Category Badge
                      Container(
                        decoration: BoxDecoration(
                          color: categoryBgColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        child: Text(
                          expense.category,
                          style: AppTypography.caption.copyWith(
                            color: categoryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Date
                      Text(
                        _formatDate(expense.date),
                        style: AppTypography.caption.copyWith(
                          color: ColorPalette.tertiaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: AppTypography.body.copyWith(
                    color: ColorPalette.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                if (expense.description != null && expense.description!.isNotEmpty)
                  Text(
                    'Has note',
                    style: AppTypography.caption.copyWith(
                      color: ColorPalette.tertiaryText,
                    ),
                  )
                else
                  const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon _getCategoryIcon(String category, Color color) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'groceries':
        return Icon(Icons.restaurant, color: color, size: 24);
      case 'transport':
      case 'travel':
        return Icon(Icons.directions_car, color: color, size: 24);
      case 'entertainment':
      case 'shopping':
        return Icon(Icons.shopping_bag, color: color, size: 24);
      case 'utilities':
      case 'bills':
        return Icon(Icons.receipt, color: color, size: 24);
      case 'health':
      case 'fitness':
        return Icon(Icons.favorite, color: color, size: 24);
      case 'education':
        return Icon(Icons.school, color: color, size: 24);
      case 'other':
      default:
        return Icon(Icons.tag, color: color, size: 24);
    }
  }
}
