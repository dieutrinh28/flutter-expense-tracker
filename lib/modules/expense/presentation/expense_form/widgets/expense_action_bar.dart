import 'package:flutter/material.dart';
import '../../../../../core/theme/color_palette.dart';
import '../../../../../core/theme/typography.dart';
import '../config/screen_mode.dart';

class ExpenseActionBar extends StatelessWidget {
  final ScreenMode mode;
  final bool isSaving;
  final VoidCallback? onSave;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ExpenseActionBar({
    super.key,
    required this.mode,
    required this.isSaving,
    this.onSave,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mode.showSaveButton)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSaving ? null : onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        mode == ScreenMode.create ? 'Save Expense' : 'Update Expense',
                        style: AppTypography.button.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          if (mode.showEditButton && mode != ScreenMode.edit) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: onEdit,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ColorPalette.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Edit'),
              ),
            ),
          ],
          if (mode.showDeleteButton) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: onDelete,
              child: const Text(
                'Delete Expense',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
