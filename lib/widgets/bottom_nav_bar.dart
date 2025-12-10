import 'package:blinkit/common_widgets/blinkit_common_svg.dart';
import 'package:blinkit/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class BlinkitBottomNav extends StatefulWidget {
  const BlinkitBottomNav({super.key});

  @override
  State<BlinkitBottomNav> createState() => _BlinkitBottomNavState();
}

class _BlinkitBottomNavState extends State<BlinkitBottomNav> {
  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: ClipRect(
          child: Align(
            heightFactor: controller.isBottomNavVisible.value ? 1 : 0,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 60,
                child: _bottomNavBar(),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      currentIndex: controller.selectedTabIndex.value,
      onTap: controller.selectTab,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: Colors.black,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      items: [
        BottomNavigationBarItem(
          icon: BlinkitCommonSVGIcon(
            image: AppImages.blinkitHome,
            height: 22,
            width: 22,
          ),
          activeIcon:
              BlinkitCommonSVGIcon(image: AppImages.blinkitHome, height: 22, width: 22, color: const Color(0xFFFEC300)),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: BlinkitCommonSVGIcon(
            image: AppImages.blinkitBasket,
            height: 22,
            width: 22,
          ),
          activeIcon: BlinkitCommonSVGIcon(
              image: AppImages.blinkitBasket, height: 22, width: 22, color: const Color(0xFFFEC300)),
          label: "Order Again",
        ),
        BottomNavigationBarItem(
          icon: BlinkitCommonSVGIcon(
            image: AppImages.blinkitMenu,
            height: 22,
            width: 22,
          ),
          activeIcon:
              BlinkitCommonSVGIcon(image: AppImages.blinkitMenu, height: 22, width: 22, color: const Color(0xFFFEC300)),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: BlinkitCommonSVGIcon(
            image: AppImages.blinkitPrinter,
            height: 22,
            width: 22,
          ),
          activeIcon: BlinkitCommonSVGIcon(
              image: AppImages.blinkitPrinter, height: 22, width: 22, color: const Color(0xFFFEC300)),
          label: "Print",
        ),
      ],
    );
  }
}
