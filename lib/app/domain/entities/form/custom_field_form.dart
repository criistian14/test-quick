import 'package:formz/formz.dart';
import 'package:get/get.dart';

class CustomFieldForm extends FormzInput<String, String> {
  const CustomFieldForm.pure() : super.pure('');
  const CustomFieldForm.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value.isEmpty) {
      return 'field_invalid'.tr;
    }

    return null;
  }
}
