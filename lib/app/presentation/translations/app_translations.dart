import 'package:get/get.dart';

import 'forms.dart';
import 'messages.dart';
import 'titles.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          ...TitlesTranslations().en,
          ...FormsTranslations().en,
          ...MessagesTranslations().en,
        },
        "es_CO": {
          ...TitlesTranslations().es,
          ...FormsTranslations().es,
          ...MessagesTranslations().es,
        }
      };
}
