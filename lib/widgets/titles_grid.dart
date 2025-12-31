import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class PinkTilesGrid extends StatelessWidget {
  const PinkTilesGrid({super.key});

  final List<Map<String, dynamic>> tiles = const [
    {"title": "Party\nEssentials", "icon": Icons.celebration},
    {"title": "Wedding\nEssentials", "icon": Icons.favorite},
    {"title": "Gifting\nCorner", "icon": Icons.card_giftcard},
    {"title": "Pooja\nEssentials", "icon": Icons.lightbulb},
    {"title": "Fashion\n& Beauty", "icon": Icons.brush},
    {"title": "Decoration\nItems", "icon": Icons.color_lens},
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    final availableWidth = MediaQuery.of(context).size.width - 32 - 20;
    final tileSize = availableWidth / 3;

    return SizedBox(
      height: tileSize * 2 + 10,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          final tile = tiles[index];

          return Obx(() {
            Color tileBg;
            Color circleBg;

            switch (controller.currentTab.value) {
              case HomeTab.orderAgain:
                tileBg = const Color(0xFFFFE8ED);
                circleBg = const Color(0xFFFFC1D9);
                break;
              case HomeTab.categories:
                tileBg = const Color(0xFFE3F2FD);
                circleBg = const Color(0xFFBBDEFB);
                break;
              case HomeTab.print:
                tileBg = const Color(0xFFE8F5E9);
                circleBg = const Color(0xFFC8E6C9);
                break;
              case HomeTab.home:
              default:
                tileBg = const Color(0xFFFFF6CC);
                circleBg = const Color(0xFFFFE082);
            }

            return Container(
              decoration: BoxDecoration(
                color: tileBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: circleBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      tile["icon"],
                      size: 26,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tile["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.25,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
