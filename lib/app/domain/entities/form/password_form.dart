import 'package:formz/formz.dart';
import 'package:get/get.dart';

class PasswordForm extends FormzInput<String, String> {
  const PasswordForm.pure() : super.pure('');
  const PasswordForm.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if(value.length < 6){
      return 'password_invalid'.tr;
    }

    return null;
  }

}