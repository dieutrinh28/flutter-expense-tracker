enum ScreenMode { create, edit, view, detail }

extension ScreenModeX on ScreenMode {
  // ── Edit ability ──────────────────────────────────────────────
  bool get isEditable => this == ScreenMode.create || this == ScreenMode.edit;

  bool get isReadOnly => !isEditable;

  // ── Visibility ───────────────────────────────────────────────
  bool get showDetailSection => this == ScreenMode.detail;

  bool get showDeleteButton =>
      this == ScreenMode.view || this == ScreenMode.detail;

  bool get showEditButton =>
      this == ScreenMode.view || this == ScreenMode.detail;

  bool get showSaveButton => isEditable;

  // ── Title ─────────────────────────────────────────────────────
  String get screenTitle => switch (this) {
        ScreenMode.create => 'Add Expense',
        ScreenMode.edit => 'Edit Expense',
        ScreenMode.view => 'Expense',
        ScreenMode.detail => 'Expense Detail',
      };
}
