import 'package:flutter/foundation.dart';

@immutable
class FormButton {
  const FormButton({
    this.enabled = true,
    this.visible = true,
    this.isPending = false,
  });

  // кнопка активна / кликабельна
  final bool enabled;

  // кнопка видима
  final bool visible;

  // на кнопке отображается индикатор ожидания
  final bool isPending;

  bool get clickable => enabled && visible && !isPending;

  FormButton copyWith({
    bool? enabled,
    bool? visible,
    bool? isPending,
  }) =>
      FormButton(
        enabled: enabled ?? this.enabled,
        visible: visible ?? this.visible,
        isPending: isPending ?? this.isPending,
      );
}

// -----------------------------------------------------------------------------
@immutable
base class FormField<T> {
  FormField({
    // значение поля
    T? value,
    // обязательно ли для заполнения
    bool requiredField = false,
    // спрятать состояние ошибки
    bool hideErrorState = true,
    // Поле доступно для взаимодействия / активно
    bool enabled = true,
    // поле отображается на форме
    bool visible = true,
    // ограничение минимальной длины введённого значения
    int? minLength,
    // ограничение максимальной длины введённого значения
    int? maxLength,
    // принудительное указание текста ошибки
    String? customErrorText,
  })  : _value = value,
        _requiredField = requiredField,
        _hideErrorState = hideErrorState,
        _minLength = minLength,
        _maxLength = maxLength,
        _visible = visible,
        _enabled = enabled,
        assert((minLength ?? 0) >= 0, 'minLength is not negative value'),
        assert(minLength == null || maxLength == null || minLength <= maxLength,
            'minLength is not bigger than maxLength') {
    _customErrorText = customErrorText;
    _errorOnValidator = !_specificValidator(_value);
    _errorOnEmptyRequiredValue = requiredField && validatorIsEmpty(value);
  }

  // ---------------------------------------------------------------------------
  /// Основное значение поля
  final T? _value;

  // ---------------------------------------------------------------------------
  /// Дополнительные настройки поля формы

  /// Указывает - обязательно ли поле для заполнения?
  /// Не учавствует в валидации и просто служит дополнительной информацией
  /// для отображения на форме.
  /// По-умолчанию false
  final bool _requiredField;

  /// Если есть ошибка валидации, то при [_hideErrorState] = true можно
  /// спрятать эту ошибку в интерфейсе. По-умолчанию true, чтобы не
  /// показывать ошибки на новых формах
  final bool _hideErrorState;

  /// Поле указывающее на то, нужно ли отображать это поле на форме.
  /// Встречаются кейсы, когда некоторые поля формы в некоторых ситуациях
  /// нужно спрятать. По-умолчанию поле всегда видимое
  final bool _visible;

  /// Поле доступно для взаимодействия / активно
  final bool _enabled;

  /// ограничение минимальной длины введённого значения
  final int? _minLength;

  /// ограничение максимальной длины введённого значения
  final int? _maxLength;

  /// хранит текст ошибки для этого поля, который назначен "извне", например
  /// при проверке этого поля на бэке
  late final String? _customErrorText;

  /// ошибка по результату работы основного валидатора
  late final bool _errorOnValidator;

  /// ошибка, если поле пустое, но помечено как обязательное
  late final bool _errorOnEmptyRequiredValue;

  // ---------------------------------------------------------------------------
  /// геттеры
  T? get value => _value;

  bool get requiredField => _requiredField;

  bool get hideErrorState => _hideErrorState;

  bool get enabled => _enabled;

  bool get visible => _visible;

  int? get minLength => _minLength;

  int? get maxLength => _maxLength;

  String? get customErrorText => _customErrorText;

  @mustCallSuper
  bool get valid =>
      !_errorOnValidator &&
      !_errorOnEmptyRequiredValue &&
      (_customErrorText?.isEmpty ?? true) &&
      !_errorOnLengthValidator();

  bool get invalid => !valid;

  bool get errorOnEmpty => _errorOnEmptyRequiredValue;

  bool get errorOnValidator => _errorOnValidator;

  bool get errorOnLengthValidator => _errorOnLengthValidator();

  // ---------------------------------------------------------------------------
  /// Валидатор длины
  bool _errorOnLengthValidator() {
    // если установлено условие для минимальной длины значения
    if (_minLength != null) {
      if (_value == null || _value.toString().length < _minLength!) {
        return true;
      }
    }
    if (_maxLength != null) {
      if (_value != null && _value.toString().length > _maxLength!) {
        return true;
      }
    }
    return false;
  }

  // ---------------------------------------------------------------------------
  /// Валидатор данных для значения поля
  bool _specificValidator(T? value) {
    throw UnimplementedError('Method validator is not implemented');
  }

  // ---------------------------------------------------------------------------
  /// Валидатор для пустых значений поля
  bool validatorIsEmpty(T? value) => value == null || '$value'.isEmpty;

  // ---------------------------------------------------------------------------
  FormField<T> copyWithCustomError(String? errorText) {
    throw UnimplementedError('Method copyWithError is not implemented');
  }

  // ---------------------------------------------------------------------------
  FormField<T> copyWithValue(T? value) {
    throw UnimplementedError('Method copyWithValue is not implemented');
  }

  // ---------------------------------------------------------------------------
  FormField<T> copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
  }) {
    throw UnimplementedError('Method copyWithParameters is not implemented');
  }

  // ---------------------------------------------------------------------------
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormField &&
          runtimeType == other.runtimeType &&
          _requiredField == other._requiredField &&
          _hideErrorState == other._hideErrorState &&
          _visible == other._visible &&
          _value == other._value &&
          _enabled == other._enabled &&
          _customErrorText == other._customErrorText;

  @override
  int get hashCode => value.hashCode;
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Простое универсальное поле ввода с дженериком
/// Обычно подходит для ComboBox
@immutable
final class FormFieldValue<T> extends FormField<T> {
  FormFieldValue({
    T? value,
    bool requiredField = false,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    String? customErrorText,
  }) : super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        );

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(T? value) => true;

  // ---------------------------------------------------------------------------
  @override
  FormFieldValue<T> copyWithValue(T? value) => FormFieldValue<T>(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldValue<T> copyWithCustomError(String? errorText) => FormFieldValue(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: errorText,
        minLength: minLength,
        maxLength: maxLength,
      );

// ---------------------------------------------------------------------------
  @override
  FormFieldValue<T> copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
  }) =>
      FormFieldValue(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Простое поле ввода для текста
/// Отличие от [FormFieldValue] в способе проверки пустого значения
@immutable
final class FormFieldString extends FormField<String> {
  FormFieldString({
    String? value,
    bool requiredField = false,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    String? customErrorText,
  }) : super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        );

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(String? value) => true;

  // ---------------------------------------------------------------------------
  @override
  FormFieldString copyWithValue(String? value) => FormFieldString(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldString copyWithCustomError(String? errorText) => FormFieldString(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: errorText,
        minLength: minLength,
        maxLength: maxLength,
      );

// ---------------------------------------------------------------------------
  @override
  FormFieldString copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
  }) =>
      FormFieldString(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Поле для ввода числа
/// Выполняется проверка корректности введенного числа
@immutable
final class FormFieldNumber extends FormField<String> {
  FormFieldNumber({
    String? value,
    bool requiredField = false,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    String? customErrorText,
    bool isDecimal = true,
    bool notNegative = false,
  })  : _isDecimal = isDecimal,
        _notNegative = notNegative,
        super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        ) {
    _errorOnNumberFormat = !_specificValidator(value);
    _errorOnNotNegative = !_validateNegativeNumbers(value);
  }

  // ---------------------------------------------------------------------------
  // специфические свойства и геттеры
  final bool _isDecimal;
  final bool _notNegative;

  late final bool _errorOnNumberFormat;
  late final bool _errorOnNotNegative;

  bool get isDecimal => _isDecimal;

  bool get notNegative => _notNegative;

  bool get errorOnNumberFormat => _errorOnNumberFormat;

  bool get errorOnNotNegative => _errorOnNotNegative;

  // ---------------------------------------------------------------------------
  @override
  bool get valid =>
      super.valid && !_errorOnNumberFormat && !_errorOnNotNegative;

  // ---------------------------------------------------------------------------
  int? toInt() =>
      double.tryParse(value?.replaceAll(',', '.').trim() ?? '')?.toInt();

  // ---------------------------------------------------------------------------
  double? toDouble() =>
      double.tryParse(value?.replaceAll(',', '.').trim() ?? '');

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(String? value) => isDecimal
      ? (double.tryParse(value?.replaceAll(',', '.').trim() ?? '') != null)
      : (int.tryParse(value?.trim() ?? '') != null);

  // ---------------------------------------------------------------------------
  bool _validateNegativeNumbers(String? value) {
    final num? number = isDecimal
        ? (double.tryParse(value?.replaceAll(',', '.').trim() ?? ''))
        : (int.tryParse(value?.trim() ?? ''));
    return number == null || !_notNegative || (_notNegative && number >= 0);
  }

// ---------------------------------------------------------------------------
  @override
  FormFieldNumber copyWithValue(String? value) => FormFieldNumber(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        isDecimal: _isDecimal,
        minLength: minLength,
        maxLength: maxLength,
        notNegative: notNegative,
      );

// ---------------------------------------------------------------------------
  @override
  FormFieldNumber copyWithCustomError(String? errorText) => FormFieldNumber(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: errorText,
        isDecimal: _isDecimal,
        minLength: minLength,
        maxLength: maxLength,
        notNegative: notNegative,
      );

// ---------------------------------------------------------------------------
  @override
  FormFieldNumber copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
    bool? isDecimal,
    bool? notNegative,
  }) =>
      FormFieldNumber(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        isDecimal: isDecimal ?? this.isDecimal,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
        notNegative: notNegative ?? this.notNegative,
      );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Поле ввода почты
@immutable
final class FormFieldEmail extends FormField<String?> {
  FormFieldEmail({
    String? value,
    bool requiredField = false,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    String? customErrorText,
  })  : _errorOnEmailFormat = !_validatorEmailFormat(value),
        super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        );

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)+$',
  );

  // ---------------------------------------------------------------------------
  // специфические свойства и геттеры
  late final bool _errorOnEmailFormat;

  bool get errorOnEmailFormat => _errorOnEmailFormat;

  static bool _validatorEmailFormat(String? value) =>
      _emailRegExp.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(String? value) => !errorOnEmailFormat;

  // ---------------------------------------------------------------------------
  @override
  FormFieldEmail copyWithValue(String? value) => FormFieldEmail(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldEmail copyWithCustomError(String? errorText) => FormFieldEmail(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: errorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldEmail copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
  }) =>
      FormFieldEmail(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Поле ввода телефона
@immutable
final class FormFieldPhone extends FormField<String?> {
  FormFieldPhone({
    String? value,
    bool requiredField = false,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    String? customErrorText,
  })  : _errorOnPhoneFormat = _validatorPhoneFormat(value),
        super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        );

  static final _phoneRegExp = RegExp(
    r'^\+\d \(\d{3}\) \d{3}-\d{2}-\d{2}$',
  );

  // ---------------------------------------------------------------------------
  // специфические свойства и геттеры
  late final bool _errorOnPhoneFormat;

  bool get errorOnPhoneFormat => _errorOnPhoneFormat;

  // ---------------------------------------------------------------------------
  static bool _validatorPhoneFormat(String? value) =>
      !_phoneRegExp.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(String? value) => !_errorOnPhoneFormat;

  // ---------------------------------------------------------------------------
  @override
  FormFieldPhone copyWithValue(String? value) => FormFieldPhone(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldPhone copyWithCustomError(String? errorText) => FormFieldPhone(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        customErrorText: errorText,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldPhone copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
  }) =>
      FormFieldPhone(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        customErrorText: customErrorText,
        minLength: minLength,
        maxLength: maxLength,
      );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// Поле ввода пароля
@immutable
final class FormFieldPassword extends FormField<String?> {
  FormFieldPassword({
    String? value,
    bool requiredField = true,
    bool hideErrorState = true,
    bool visible = true,
    bool enabled = true,
    int? minLength,
    int? maxLength,
    bool isObscured = true,
    String? customErrorText,
  })  : _errorOnWrongLength = _validatorWrongLength(value),
        _errorOnContainNonEnglishLetters = _validatorContainNonEnglish(value),
        _errorOnMissingLowercaseLetters = !_validatorHasLowercaseLetters(value),
        _errorOnMissingUppercaseLetters = !_validatorHasUppercaseLetters(value),
        _errorOnMissingDigits = !_validatorContainDigits(value),
        _isObscured = isObscured,
        super(
          value: value,
          requiredField: requiredField,
          hideErrorState: hideErrorState,
          visible: visible,
          enabled: enabled,
          minLength: minLength,
          maxLength: maxLength,
          customErrorText: customErrorText,
        );

  static final RegExp hasNonEnglishLetters = RegExp(r'[^\x00-\x7F]');
  static final RegExp lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp numbersRegex = RegExp(r'[0-9]');

  // ---------------------------------------------------------------------------
  // специфические свойства и геттеры
  late final bool _isObscured;
  late final bool _errorOnWrongLength;
  late final bool _errorOnContainNonEnglishLetters;
  late final bool _errorOnMissingLowercaseLetters;
  late final bool _errorOnMissingUppercaseLetters;
  late final bool _errorOnMissingDigits;

  bool get isObscured => _isObscured;

  bool get errorOnWrongLength => _errorOnWrongLength;

  bool get errorOnContainNonEnglishLetters => _errorOnContainNonEnglishLetters;

  bool get errorOnMissingLowercaseLetters => _errorOnMissingLowercaseLetters;

  bool get errorOnMissingUppercaseLetters => _errorOnMissingUppercaseLetters;

  bool get errorOnMissingDigits => _errorOnMissingDigits;

  // ---------------------------------------------------------------------------
  // Если длина от 8 до 20 знаков
  static bool _validatorWrongLength(String? value) =>
      value == null || value.length < 8 || value.length > 20;

  // ---------------------------------------------------------------------------
  // Если вводятся кириллические символы
  static bool _validatorContainNonEnglish(String? value) =>
      hasNonEnglishLetters.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  // Не менее одной строчной буквы
  static bool _validatorHasLowercaseLetters(String? value) =>
      lowercaseRegex.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  // Не менее одной прописной буквы
  static bool _validatorHasUppercaseLetters(String? value) =>
      uppercaseRegex.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  // Не менее одной цифры
  static bool _validatorContainDigits(String? value) =>
      numbersRegex.hasMatch(value ?? '');

  // ---------------------------------------------------------------------------
  @override
  bool _specificValidator(String? value) => true;

  // ---------------------------------------------------------------------------
  @override
  bool get valid =>
      super.valid &&
      !_errorOnWrongLength &&
      !_errorOnContainNonEnglishLetters &&
      !_errorOnMissingLowercaseLetters &&
      !_errorOnMissingUppercaseLetters &&
      !_errorOnMissingDigits;

  // ---------------------------------------------------------------------------
  // @override
  // bool get valid => super.valid && !_errorOnNumberFormat;

// ---------------------------------------------------------------------------
  @override
  FormFieldPassword copyWithValue(String? value) => FormFieldPassword(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: customErrorText,
        isObscured: _isObscured,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldPassword copyWithCustomError(String? errorText) => FormFieldPassword(
        value: value,
        requiredField: requiredField,
        hideErrorState: hideErrorState,
        visible: visible,
        enabled: enabled,
        customErrorText: errorText,
        isObscured: _isObscured,
        minLength: minLength,
        maxLength: maxLength,
      );

  // ---------------------------------------------------------------------------
  @override
  FormFieldPassword copyWithParameters({
    bool? requiredField,
    bool? hideErrorState,
    bool? visible,
    bool? enabled,
    bool? isObscured,
  }) =>
      FormFieldPassword(
        value: value,
        requiredField: requiredField ?? this.requiredField,
        hideErrorState: hideErrorState ?? this.hideErrorState,
        visible: visible ?? this.visible,
        enabled: enabled ?? this.enabled,
        customErrorText: customErrorText,
        isObscured: isObscured ?? this.isObscured,
        minLength: minLength,
        maxLength: maxLength,
      );
}
