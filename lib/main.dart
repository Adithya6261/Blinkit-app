import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/home_binding.dart';
import 'themes/app_theme.dart';
import 'utils/app_routes.dart';

void main() {
    // GestureBinding.instance.resamplingEnabled = true;
  runApp(const MyApp());
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // showPerformanceOverlay: true,
      
      title: 'Blinkit Home Clone',
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      theme: AppTheme.light,
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}
