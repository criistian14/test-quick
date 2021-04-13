import 'package:formz/formz.dart';
import 'package:get/get.dart';

class FirstNameForm extends FormzInput<String, String> {
  const FirstNameForm.pure() : super.pure('');
  const FirstNameForm.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if(value.isEmpty){
      return 'field_invalid'.tr;
    }

    return null;
  }

}