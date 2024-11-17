import 'package:app_template/core/utils/form_fields.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String validPassword;
  late String validPhone;
  late String validEmail;
  late String validIntegerNumber;
  late String validDecimalNumber;

  setUpAll(() {
    validPassword = 'noSc76_fN21k';
    validPhone = '+7 (987) 654-32-10';
    validEmail = 'akv_ds@vmwpvw.vob.vdw';
    validIntegerNumber = '5468';
    validDecimalNumber = '5843.345223';
  });

  // -------------------------------------------------------------------------
  // FormButton
  // -------------------------------------------------------------------------
  group('Check form utils: FormButton', () {
    test('FormFieldPassword -> Check copyWith', () {
      const t1 = FormButton(
        enabled: false,
        visible: false,
        isPending: true,
      );

      expect(t1.enabled, false);
      expect(t1.visible, false);
      expect(t1.isPending, true);

      final t2 = t1.copyWith(
        enabled: true,
        visible: true,
        isPending: false,
      );
      expect(t2.enabled, true);
      expect(t2.visible, true);
      expect(t2.isPending, false);
    });
  });

  // -------------------------------------------------------------------------
  // FormFieldPassword
  // -------------------------------------------------------------------------
  group('Check custom validators', () {
    final catValidator = CatValidator();
    final dogValidator = DogValidator();

    test('Validate whith catValidator', () {
      final t1 = FormFieldString(value: 'dog', maxLength: 10);
      expect(t1.valid, true);

      final t2 = FormFieldString(
        value: 'dog-cat',
        maxLength: 10,
        validators: [catValidator],
      );
      expect(t2.valid, true);

      final t3 = FormFieldString(
        value: 'only dog',
        maxLength: 10,
        validators: [catValidator],
      );
      expect(t3.valid, false);
    });

    test('Validate whith several validators', () {
      final t1 = FormFieldString(value: 'dog', maxLength: 10);
      expect(t1.valid, true);

      final t2 = FormFieldString(
        value: 'dog-cat',
        maxLength: 10,
        validators: [dogValidator, catValidator],
      );
      expect(t2.valid, true);

      final t3 = FormFieldString(
        value: 'only dog',
        maxLength: 10,
        validators: [dogValidator, catValidator],
      );
      expect(t3.valid, false);
    });

    test('Get type of triggered validator', () {
      final t2 = FormFieldString(
        value: 'dog-cat',
        maxLength: 10,
        validators: [dogValidator, catValidator],
      );

      expect(t2.validatorsWithErrors.contains(dogValidator), false);
      expect(t2.validatorsWithErrors.contains(catValidator), false);

      final t3 = FormFieldString(
        value: 'only dog',
        maxLength: 10,
        validators: [dogValidator, catValidator],
      );
      expect(t3.validatorsWithErrors.contains(dogValidator), false);
      expect(t3.validatorsWithErrors.contains(catValidator), true);
    });
  });

  // -------------------------------------------------------------------------
  // FormFieldPassword
  // -------------------------------------------------------------------------
  group('Check form utils: FormField minLength+maxLength', () {
    test('minLength is always less than maxLength', () {
      // исключение при некорректных ограничениях длины
      expect(() {
        FormFieldString(minLength: 10, maxLength: 4);
      }, throwsA(isA<AssertionError>()));
      // корректные значения длины
      FormFieldString(minLength: 10);
      FormFieldString(maxLength: 20);
      FormFieldString(minLength: 10, maxLength: 20);
      FormFieldString(minLength: 4, maxLength: 4);
    });
    // -------------------------------------------------------------------------
    test('minLength is not negative value', () {
      // исключение при некорректных ограничениях длины
      expect(() {
        FormFieldString(minLength: -2);
      }, throwsA(isA<AssertionError>()));
    });
    // -------------------------------------------------------------------------
    test('invalid  on: empty value and wrong minimal length', () {
      final t1 = FormFieldString(minLength: 4, maxLength: 10);
      expect(t1.invalid, true);
    });
    // -------------------------------------------------------------------------
    test('invalid  on: initialized value and wrong minimal length', () {
      final t1 = FormFieldString(value: 'abc', minLength: 4, maxLength: 10);
      expect(t1.invalid, true);
      final t2 = FormFieldString(value: 'abcde', minLength: 4, maxLength: 10);
      expect(t2.valid, true);
    });
    // -------------------------------------------------------------------------
    test('valid  on: empty value and wrong max length', () {
      final t1 = FormFieldString(maxLength: 10);
      expect(t1.valid, true);
    });
    // -------------------------------------------------------------------------
    test('valid  on: initialized value and wrong max length', () {
      final t1 = FormFieldString(value: 'abc', maxLength: 10);
      expect(t1.valid, true);
      final t2 =
          FormFieldString(value: 'abcdefghi', minLength: 2, maxLength: 5);
      expect(t2.invalid, true);
    });
    // -------------------------------------------------------------------------
    test('valid on: min and max length', () {
      final t1 = FormFieldString(value: 'abc', minLength: 2, maxLength: 4);
      expect(t1.valid, true);
      final t2 =
          FormFieldString(value: 'abcdefghi', minLength: 2, maxLength: 4);
      expect(t2.invalid, true);
      final t3 = FormFieldString(value: 'a', minLength: 2, maxLength: 4);
      expect(t3.invalid, true);
      final t4 = FormFieldString(value: 'abc', minLength: 3, maxLength: 3);
      expect(t4.valid, true);
    });
  });

  group('Check form utils: FormFieldPassword', () {
    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check default settings initialization', () {
      final t1 = FormFieldPassword();
      expect(t1.value, null);
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.isObscured, true);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check custom settings initialization', () {
      final t1 = FormFieldPassword(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        isObscured: false,
        minLength: 1,
        maxLength: 2,
      );
      expect(t1.value, 'test1');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.isObscured, false);
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check copyWithValue method', () {
      FormFieldPassword t1 = FormFieldPassword(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isObscured: false,
      );
      t1 = t1.copyWithValue(validPassword);
      expect(t1.value, validPassword);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
      expect(t1.isObscured, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check copyWithCustomError method', () {
      FormFieldPassword t1 = FormFieldPassword(
        value: validPassword,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isObscured: false,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check copyWithParameters method', () {
      FormFieldPassword t1 = FormFieldPassword(
        value: validPassword,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isObscured: false,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.isObscured, false);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
        isObscured: true,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.isObscured, true);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.isObscured, true);
      expect(t1.value, validPassword);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> Check custom error text initialization', () {
      final t1 = FormFieldPassword(
        value: 'test1',
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldPassword(value: 'test1', requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldPassword(value: 'test1', requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t3 = FormFieldPassword(value: '', requiredField: false);
      expect(t3.errorOnEmpty, false);

      final t4 = FormFieldPassword(value: '', requiredField: true);
      expect(t4.errorOnEmpty, true);
      expect(t4.invalid, true);

      final t5 = FormFieldPassword(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnWrongLength flag test', () {
      final t1 = FormFieldPassword();
      expect(t1.errorOnWrongLength, true);
      expect(t1.invalid, true);

      final t2 = FormFieldPassword(value: '');
      expect(t2.errorOnWrongLength, true);
      expect(t2.invalid, true);

      final t3 = FormFieldPassword(value: '1234567');
      expect(t3.errorOnWrongLength, true);
      expect(t3.invalid, true);

      final t4 = FormFieldPassword(value: '12345678');
      expect(t4.errorOnWrongLength, false);

      final t5 = FormFieldPassword(value: '12345678901234567890');
      expect(t5.errorOnWrongLength, false);

      final t6 = FormFieldPassword(value: '123456789012345678901');
      expect(t6.errorOnWrongLength, true);
      expect(t6.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnContainNonEnglishLetters flag test', () {
      final t1 = FormFieldPassword();
      expect(t1.errorOnContainNonEnglishLetters, false);

      final t2 = FormFieldPassword(value: '');
      expect(t2.errorOnContainNonEnglishLetters, false);

      final t3 = FormFieldPassword(value: 'dvsddsb');
      expect(t3.errorOnContainNonEnglishLetters, false);

      final t4 = FormFieldPassword(value: 'я');
      expect(t4.errorOnContainNonEnglishLetters, true);
      expect(t4.invalid, true);

      final t5 = FormFieldPassword(value: 'Я');
      expect(t5.errorOnContainNonEnglishLetters, true);
      expect(t5.invalid, true);

      final t6 = FormFieldPassword(value: 'zя');
      expect(t6.errorOnContainNonEnglishLetters, true);
      expect(t6.invalid, true);

      final t7 = FormFieldPassword(value: 'ZЯ');
      expect(t7.errorOnWrongLength, true);
      expect(t7.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnMissingLowercaseLetters flag test', () {
      final t1 = FormFieldPassword();
      expect(t1.errorOnMissingLowercaseLetters, true);
      expect(t1.invalid, true);

      final t2 = FormFieldPassword(value: '');
      expect(t2.errorOnMissingLowercaseLetters, true);
      expect(t2.invalid, true);

      final t3 = FormFieldPassword(value: 'JBHJF345');
      expect(t3.errorOnMissingLowercaseLetters, true);
      expect(t3.invalid, true);

      final t4 = FormFieldPassword(value: 'я');
      expect(t4.errorOnMissingLowercaseLetters, true);
      expect(t4.invalid, true);

      final t5 = FormFieldPassword(value: 'z');
      expect(t5.errorOnMissingLowercaseLetters, false);

      final t6 = FormFieldPassword(value: 'JYa');
      expect(t6.errorOnMissingLowercaseLetters, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnMissingUppercaseLetters flag test', () {
      final t1 = FormFieldPassword();
      expect(t1.errorOnMissingUppercaseLetters, true);
      expect(t1.invalid, true);

      final t2 = FormFieldPassword(value: '');
      expect(t2.errorOnMissingUppercaseLetters, true);
      expect(t2.invalid, true);

      final t3 = FormFieldPassword(value: 'sdvsd345');
      expect(t3.errorOnMissingUppercaseLetters, true);
      expect(t3.invalid, true);

      final t4 = FormFieldPassword(value: 'Я');
      expect(t4.errorOnMissingUppercaseLetters, true);
      expect(t4.invalid, true);

      final t5 = FormFieldPassword(value: 'Z');
      expect(t5.errorOnMissingUppercaseLetters, false);

      final t6 = FormFieldPassword(value: 'JYa');
      expect(t6.errorOnMissingLowercaseLetters, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPassword -> errorOnMissingDigits flag test', () {
      final t1 = FormFieldPassword();
      expect(t1.errorOnMissingDigits, true);
      expect(t1.invalid, true);

      final t2 = FormFieldPassword(value: '');
      expect(t2.errorOnMissingDigits, true);
      expect(t2.invalid, true);

      final t3 = FormFieldPassword(value: 'sdvsd');
      expect(t3.errorOnMissingDigits, true);
      expect(t3.invalid, true);

      final t4 = FormFieldPassword(value: '1');
      expect(t4.errorOnMissingDigits, false);

      final t5 = FormFieldPassword(value: 'Zdv813');
      expect(t5.errorOnMissingDigits, false);
    });
  });
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // FormFieldPhone
  // -------------------------------------------------------------------------
  group('Check form utils: FormFieldPhone', () {
    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check default settings initialization', () {
      final t1 = FormFieldPhone();
      expect(t1.value, null);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check custom settings initialization', () {
      final t1 = FormFieldPhone(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        minLength: 1,
        maxLength: 2,
      );
      expect(t1.value, 'test1');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check copyWithValue method', () {
      FormFieldPhone t1 = FormFieldPhone(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      t1 = t1.copyWithValue(validPhone);
      expect(t1.value, validPhone);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check copyWithCustomError method', () {
      FormFieldPhone t1 = FormFieldPhone(
        value: validPhone,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check copyWithParameters method', () {
      FormFieldPhone t1 = FormFieldPhone(
        value: validPhone,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> Check custom error text initialization', () {
      final t1 = FormFieldPhone(
        value: 'test1',
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldPhone(value: 'test1', requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldPhone(value: 'test1', requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t3 = FormFieldPhone(value: '', requiredField: false);
      expect(t3.errorOnEmpty, false);

      final t4 = FormFieldPhone(value: '', requiredField: true);
      expect(t4.errorOnEmpty, true);
      expect(t4.invalid, true);

      final t5 = FormFieldPhone(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldPhone -> errorOnPhoneFormat flag test', () {
      final t1 = FormFieldPhone();
      expect(t1.errorOnPhoneFormat, true);
      expect(t1.invalid, true);

      final t2 = FormFieldPhone(value: '');
      expect(t2.errorOnPhoneFormat, true);
      expect(t2.invalid, true);

      final t3 = FormFieldPhone(value: '12345678');
      expect(t3.errorOnPhoneFormat, true);
      expect(t3.invalid, true);

      final t4 = FormFieldPhone(value: validPhone);
      expect(t4.errorOnPhoneFormat, false);
    });
  });
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // FormFieldEmail
  // -------------------------------------------------------------------------
  group('Check form utils: FormFieldEmail', () {
    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check default settings initialization', () {
      final t1 = FormFieldEmail();
      expect(t1.value, null);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check custom settings initialization', () {
      final t1 = FormFieldEmail(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        minLength: 1,
        maxLength: 2,
      );
      expect(t1.value, 'test1');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check copyWithValue method', () {
      FormFieldEmail t1 = FormFieldEmail(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      t1 = t1.copyWithValue(validEmail);
      expect(t1.value, validEmail);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check copyWithCustomError method', () {
      FormFieldEmail t1 = FormFieldEmail(
        value: validEmail,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check copyWithParameters method', () {
      FormFieldEmail t1 = FormFieldEmail(
        value: validEmail,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> Check custom error text initialization', () {
      final t1 = FormFieldEmail(
        value: 'test1',
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldEmail(value: 'test1', requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldEmail(value: 'test1', requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t3 = FormFieldEmail(value: '', requiredField: false);
      expect(t3.errorOnEmpty, false);

      final t4 = FormFieldEmail(value: '', requiredField: true);
      expect(t4.errorOnEmpty, true);
      expect(t4.invalid, true);

      final t5 = FormFieldEmail(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldEmail -> errorOnPhoneFormat flag test', () {
      final t1 = FormFieldEmail();
      expect(t1.errorOnEmailFormat, true);
      expect(t1.invalid, true);

      final t2 = FormFieldEmail(value: '');
      expect(t2.errorOnEmailFormat, true);
      expect(t2.invalid, true);

      // Missing "@" symbol:
      final t3 = FormFieldEmail(value: 'example.com');
      expect(t3.errorOnEmailFormat, true);
      expect(t3.invalid, true);

      // Missing "@" symbol:
      final t4 = FormFieldEmail(value: 'useremail');
      expect(t4.errorOnEmailFormat, true);
      expect(t4.invalid, true);

      // Missing domain name:
      final t5 = FormFieldEmail(value: 'user@');
      expect(t5.errorOnEmailFormat, true);
      expect(t5.invalid, true);

      // Missing domain name:
      final t6 = FormFieldEmail(value: 'user@.com');
      expect(t6.errorOnEmailFormat, true);
      expect(t6.invalid, true);

      // Invalid characters:
      final t7 = FormFieldEmail(value: 'user@ex!ample.com');
      expect(t7.errorOnEmailFormat, true);
      expect(t7.invalid, true);

      // Invalid characters:
      final t8 = FormFieldEmail(value: 'user@ex#ample.com');
      expect(t8.errorOnEmailFormat, true);
      expect(t8.invalid, true);

      // Invalid characters:
      final t9 = FormFieldEmail(value: 'user@ex\$ample.co');
      expect(t9.errorOnEmailFormat, true);
      expect(t9.invalid, true);

      // Invalid characters:
      final t10 = FormFieldEmail(value: 'user@ex\$ample.com');
      expect(t10.errorOnEmailFormat, true);
      expect(t10.invalid, true);

      // Multiple "@" symbols:
      final t11 = FormFieldEmail(value: 'user@@example.com');
      expect(t11.errorOnEmailFormat, true);
      expect(t11.invalid, true);

      // Multiple "@" symbols:
      final t12 = FormFieldEmail(value: 'user@domain@example.com');
      expect(t12.errorOnEmailFormat, true);
      expect(t12.invalid, true);

      // Missing top-level domain:
      final t13 = FormFieldEmail(value: 'user@example');
      expect(t13.errorOnEmailFormat, true);
      expect(t13.invalid, true);

      // Missing top-level domain:
      final t14 = FormFieldEmail(value: 'user@example.');
      expect(t14.errorOnEmailFormat, true);
      expect(t14.invalid, true);

      // Missing top-level domain:
      final t15 = FormFieldEmail(value: validEmail);
      expect(t15.errorOnEmailFormat, false);
    });
  });
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // FormFieldTypedNumber
  // -------------------------------------------------------------------------
  group('Check form utils: FormFieldTypedNumber', () {
    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check default settings initialization', () {
      final t1 = FormFieldNumber();
      expect(t1.value, null);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.isDecimal, true);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
      expect(t1.notNegative, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check custom settings initialization', () {
      final t1 = FormFieldNumber(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        isDecimal: false,
        minLength: 1,
        maxLength: 2,
        notNegative: true,
      );
      expect(t1.value, 'test1');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.isDecimal, false);
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
      expect(t1.notNegative, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check copyWithValue method', () {
      FormFieldNumber t1 = FormFieldNumber(
        value: 'test1',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isDecimal: false,
        notNegative: true,
      );
      t1 = t1.copyWithValue(validIntegerNumber);
      expect(t1.value, validIntegerNumber);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
      expect(t1.isDecimal, false);
      expect(t1.notNegative, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check copyWithCustomError method', () {
      FormFieldNumber t1 = FormFieldNumber(
        value: validIntegerNumber,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isDecimal: false,
        notNegative: true,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);
      expect(t1.notNegative, true);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
      expect(t1.isDecimal, false);
      expect(t1.notNegative, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check copyWithParameters method', () {
      FormFieldNumber t1 = FormFieldNumber(
        value: validIntegerNumber,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        isDecimal: false,
        notNegative: true,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.isDecimal, false);
      expect(t1.notNegative, true);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
        isDecimal: true,
        notNegative: false,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.isDecimal, true);
      expect(t1.notNegative, false);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.isDecimal, true);
      expect(t1.notNegative, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> Check custom error text initialization', () {
      final t1 = FormFieldNumber(
        value: 'test1',
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldNumber(value: 'test1', requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldNumber(value: 'test1', requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t3 = FormFieldNumber(value: '', requiredField: false);
      expect(t3.errorOnEmpty, false);

      final t4 = FormFieldNumber(value: '', requiredField: true);
      expect(t4.errorOnEmpty, true);
      expect(t4.invalid, true);

      final t5 = FormFieldNumber(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> errorOnNotNegative', () {
      final t1 = FormFieldNumber(value: 'test1', notNegative: false);
      expect(t1.errorOnNotNegative, false);

      final t2 = FormFieldNumber(value: 'test1', notNegative: true);
      expect(t2.errorOnNotNegative, false);

      final t3 = FormFieldNumber(value: '', notNegative: false);
      expect(t3.errorOnNotNegative, false);

      final t4 = FormFieldNumber(value: '', notNegative: true);
      expect(t4.errorOnNotNegative, false);

      final t5 = FormFieldNumber(notNegative: false);
      expect(t5.errorOnNotNegative, false);

      final t6 = FormFieldNumber(notNegative: true);
      expect(t6.errorOnNotNegative, false);

      final t7 = FormFieldNumber(value: '10', notNegative: false);
      expect(t7.errorOnNotNegative, false);

      final t8 = FormFieldNumber(value: '10', notNegative: true);
      expect(t8.errorOnNotNegative, false);

      final t9 = FormFieldNumber(value: '-10', notNegative: false);
      expect(t9.errorOnNotNegative, false);

      final t10 = FormFieldNumber(value: '-10', notNegative: true);
      expect(t10.errorOnNotNegative, true);
      expect(t10.invalid, true);

      final t11 =
          FormFieldNumber(value: '10.4', notNegative: false, isDecimal: true);
      expect(t11.errorOnNotNegative, false);

      final t12 =
          FormFieldNumber(value: '10.4', notNegative: true, isDecimal: true);
      expect(t12.errorOnNotNegative, false);

      final t13 =
          FormFieldNumber(value: '-10.4', notNegative: false, isDecimal: true);
      expect(t13.errorOnNotNegative, false);

      final t14 =
          FormFieldNumber(value: '-10.4', notNegative: true, isDecimal: true);
      expect(t14.errorOnNotNegative, true);
      expect(t14.invalid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> errorOnPhoneFormat flag test', () {
      final t1 = FormFieldNumber();
      expect(t1.errorOnNumberFormat, true);
      expect(t1.invalid, true);

      final t2 = FormFieldNumber(value: '');
      expect(t2.errorOnNumberFormat, true);
      expect(t2.invalid, true);

      // Contain sumbols:
      final t3 = FormFieldNumber(value: '215dv');
      expect(t3.errorOnNumberFormat, true);
      expect(t3.invalid, true);

      // Contain sumbols:
      final t4 = FormFieldNumber(value: 'vsddsvsdv');
      expect(t4.errorOnNumberFormat, true);
      expect(t4.invalid, true);

      // wrong type
      final t5 = FormFieldNumber(value: '456.681', isDecimal: false);
      expect(t5.errorOnNumberFormat, true);
      expect(t5.invalid, true);

      // wrong format
      final t6 = FormFieldNumber(value: '456.681.90');
      expect(t6.errorOnNumberFormat, true);
      expect(t6.invalid, true);

      final t7 = FormFieldNumber(value: validDecimalNumber);
      expect(t7.errorOnNumberFormat, false);

      final t8 = FormFieldNumber(value: validIntegerNumber);
      expect(t8.errorOnNumberFormat, false);

      final t9 = FormFieldNumber(value: validIntegerNumber, isDecimal: false);
      expect(t9.errorOnNumberFormat, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> toInt test', () {
      final t1 = FormFieldNumber(value: '45', isDecimal: false);
      expect(t1.toInt(), 45);
      final t2 = FormFieldNumber(value: '45.23', isDecimal: false);
      expect(t2.toInt(), 45);
      final t3 = FormFieldNumber(value: '42.18', isDecimal: true);
      expect(t3.toInt(), 42);
    });

    // -------------------------------------------------------------------------
    test('FormFieldTypedNumber -> toDouble test', () {
      final t1 = FormFieldNumber(value: '45', isDecimal: false);
      expect(t1.toDouble(), 45.0);
      final t2 = FormFieldNumber(value: '45.23', isDecimal: false);
      expect(t2.toDouble(), 45.23);
      final t3 = FormFieldNumber(value: '42.18', isDecimal: true);
      expect(t3.toDouble(), 42.18);
    });
  });

  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // FormFieldValue
  // -------------------------------------------------------------------------
  group('Check form utils: FormFieldValue', () {
    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check default settings initialization', () {
      final t1 = FormFieldValue<int>();
      expect(t1.value, null);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check custom settings initialization', () {
      final t1 = FormFieldValue<int>(
        value: 123,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        minLength: 1,
        maxLength: 2,
      );
      expect(t1.value, 123);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check copyWithValue method', () {
      FormFieldValue<int> t1 = FormFieldValue<int>(
        value: 123,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      t1 = t1.copyWithValue(432);
      expect(t1.value, 432);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check copyWithCustomError method', () {
      FormFieldValue<int> t1 = FormFieldValue<int>(
        value: 123,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check copyWithParameters method', () {
      FormFieldValue<int> t1 = FormFieldValue<int>(
        value: 123,
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> Check custom error text initialization', () {
      final t1 = FormFieldValue<int>(
        value: 123,
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldValue -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldValue<int>(value: 123, requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldValue<int>(value: 123, requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t5 = FormFieldValue<int>(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });
  });

  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // FormFieldString
  // -------------------------------------------------------------------------
  group('Check form utils: FormFieldString', () {
    // -------------------------------------------------------------------------
    test('FormFieldString -> Check default settings initialization', () {
      final t1 = FormFieldString();
      expect(t1.value, null);
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
      expect(t1.customErrorText, null);
      expect(t1.minLength, null);
      expect(t1.maxLength, null);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> Check custom settings initialization', () {
      final t1 = FormFieldString(
        value: 'testX',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
        customErrorText: 'test2',
        minLength: 1,
        maxLength: 2,
      );
      expect(t1.value, 'testX');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.customErrorText, 'test2');
      expect(t1.minLength, 1);
      expect(t1.maxLength, 2);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> Check copyWithValue method', () {
      FormFieldString t1 = FormFieldString(
        value: 'testX',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      t1 = t1.copyWithValue('testZ');
      expect(t1.value, 'testZ');
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> Check copyWithCustomError method', () {
      FormFieldString t1 = FormFieldString(
        value: 'testX',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.customErrorText, null);
      expect(t1.valid, true);

      t1 = t1.copyWithCustomError('error text');
      expect(t1.customErrorText, 'error text');
      expect(t1.valid, false);

      t1 = t1.copyWithCustomError(null);
      expect(t1.customErrorText, null);
      expect(t1.valid, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> Check copyWithParameters method', () {
      FormFieldString t1 = FormFieldString(
        value: 'testX',
        requiredField: false,
        hideErrorState: false,
        visible: false,
        enabled: false,
      );
      expect(t1.requiredField, false);
      expect(t1.hideErrorState, false);
      expect(t1.visible, false);
      expect(t1.enabled, false);

      t1 = t1.copyWithParameters(
        requiredField: true,
        hideErrorState: true,
        visible: true,
        enabled: true,
      );
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);

      t1 = t1.copyWithParameters();
      expect(t1.requiredField, true);
      expect(t1.hideErrorState, true);
      expect(t1.visible, true);
      expect(t1.enabled, true);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> Check custom error text initialization', () {
      final t1 = FormFieldString(
        value: 'testX',
        customErrorText: 'test2',
      );
      expect(t1.valid, false);
    });

    // -------------------------------------------------------------------------
    test('FormFieldString -> errorOnEmpty flag on empty value', () {
      final t1 = FormFieldString(value: 'testX', requiredField: false);
      expect(t1.errorOnEmpty, false);

      final t2 = FormFieldString(value: 'testX', requiredField: true);
      expect(t2.errorOnEmpty, false);

      final t5 = FormFieldString(requiredField: true);
      expect(t5.errorOnEmpty, true);
      expect(t5.invalid, true);
    });
  });
}

class CatValidator implements FormFieldValidator<String?> {
  @override
  bool isValid(String? value) {
    return value?.contains('cat') ?? false;
  }
}

class DogValidator implements FormFieldValidator<String?> {
  @override
  bool isValid(String? value) {
    return value?.contains('dog') ?? false;
  }
}
