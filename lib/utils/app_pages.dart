import 'package:admin_traincanteen/screen/auth/login_screen.dart';
import 'package:get/get.dart';
part 'routes.dart';
class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGINSCREEN;

  static final routes = [



    GetPage(
      name: _Paths.LOGINSCREEN,

      page: () => LoginScreen(),

    ),

  ];
}
