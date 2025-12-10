import 'package:get/get.dart';
import '../screens/home_view.dart';

class AppRoutes {
  static const String home = '/';
  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeView()),
  ];
}
