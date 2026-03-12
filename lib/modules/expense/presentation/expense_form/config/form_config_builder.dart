import 'form_config.dart';
import 'screen_mode.dart';
import 'validators.dart';

abstract final class ExpenseFieldKey {
  static const amount = 'amount';
  static const title = 'title';
  static const category = 'categoryId';
  static const date = 'date';
  static const paymentMethod = 'paymentMethod';
  static const note = 'note';
  // Detail-only
  static const receipt = 'receipt';
  static const merchant = 'merchant';
  static const tags = 'tags';
}

class FormConfigBuilder {
  const FormConfigBuilder();

  FormConfig build(ScreenMode mode) => switch (mode) {
        ScreenMode.create => _createConfig(),
        ScreenMode.edit => _editConfig(),
        ScreenMode.view => _viewConfig(),
        ScreenMode.detail => _detailConfig(),
      };

  // ── Shared base fields ───────────────────────────────────────

  Map<String, FieldConfig> _baseFields({required bool editable}) => {
        ExpenseFieldKey.amount: FieldConfig(
          fieldKey: ExpenseFieldKey.amount,
          isVisible: true,
          isEditable: editable,
          isRequired: editable,
          validators: editable ? [Validators.positiveNumber] : [],
        ),
        ExpenseFieldKey.title: FieldConfig(
          fieldKey: ExpenseFieldKey.title,
          isVisible: true,
          isEditable: editable,
          isRequired: editable,
          validators: editable ? [Validators.required] : [],
        ),
        ExpenseFieldKey.category: FieldConfig(
          fieldKey: ExpenseFieldKey.category,
          isVisible: true,
          isEditable: editable,
          isRequired: editable,
          validators: editable ? [Validators.required] : [],
        ),
        ExpenseFieldKey.date: FieldConfig(
          fieldKey: ExpenseFieldKey.date,
          isVisible: true,
          isEditable: editable,
          isRequired: editable,
          validators: editable ? [Validators.required] : [],
        ),
        ExpenseFieldKey.paymentMethod: FieldConfig(
          fieldKey: ExpenseFieldKey.paymentMethod,
          isVisible: true,
          isEditable: editable,
        ),
        ExpenseFieldKey.note: FieldConfig(
          fieldKey: ExpenseFieldKey.note,
          isVisible: true,
          isEditable: editable,
        ),
      };

  Map<String, FieldConfig> _detailOnlyFields({required bool editable}) => {
        ExpenseFieldKey.receipt: FieldConfig(
          fieldKey: ExpenseFieldKey.receipt,
          isVisible: true,
          isEditable: editable,
        ),
        ExpenseFieldKey.merchant: FieldConfig(
          fieldKey: ExpenseFieldKey.merchant,
          isVisible: true,
          isEditable: editable,
        ),
        ExpenseFieldKey.tags: FieldConfig(
          fieldKey: ExpenseFieldKey.tags,
          isVisible: true,
          isEditable: editable,
        ),
      };

  // ── Mode-specific configs ────────────────────────────────────

  FormConfig _createConfig() => FormConfig(
        mode: ScreenMode.create,
        fields: _baseFields(editable: true),
        showDetailSection: false,
        isEditable: true,
        showActionBar: true,
      );

  FormConfig _editConfig() => FormConfig(
        mode: ScreenMode.edit,
        fields: _baseFields(editable: true),
        showDetailSection: false,
        isEditable: true,
        showActionBar: true,
      );

  FormConfig _viewConfig() => FormConfig(
        mode: ScreenMode.view,
        fields: _baseFields(editable: false),
        showDetailSection: false,
        isEditable: false,
        showActionBar: true,
      );

  FormConfig _detailConfig() => FormConfig(
        mode: ScreenMode.detail,
        fields: {
          ..._baseFields(editable: false),
          ..._detailOnlyFields(editable: false),
        },
        showDetailSection: true,
        isEditable: false,
        showActionBar: true,
      );
}
