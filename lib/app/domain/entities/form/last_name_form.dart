import 'package:formz/formz.dart';
import 'package:get/get.dart';

class LastNameForm extends FormzInput<String, String> {
  const LastNameForm.pure() : super.pure('');
  const LastNameForm.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if(value.isEmpty){
      return 'field_invalid'.tr;
    }

    return null;
  }

}