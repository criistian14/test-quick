import 'package:formz/formz.dart';
import 'package:get/get.dart';


class EmailForm extends FormzInput<String, String> {
  const EmailForm.pure() : super.pure('');
  const EmailForm.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if(!value.isEmail){
      return 'email_invalid'.tr;
    }

    return null;
  }

}