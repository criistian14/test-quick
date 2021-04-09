import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/routes/app_routes.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/domain/usecases/sign_out.dart';

class HomeController extends GetxController {
  final SignOut _signOut;

  HomeController({
    @required SignOut signOut,
  })  : assert(signOut != null),
        _signOut = signOut;

  void signOut() async {
    var signOutCall = await _signOut.call(NoParams());
    signOutCall.fold(Alerts.errorAlertUseCase, (r) {
      Get.offNamedUntil(AppRoutes.SIGN_IN, (route) => false);
    });
  }
}
