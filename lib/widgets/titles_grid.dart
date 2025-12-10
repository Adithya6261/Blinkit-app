import 'package:flutter/material.dart';

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
    final availableWidth = MediaQuery.of(context).size.width - 32 - 20;
    final tileSize = availableWidth / 3; 

    return SizedBox(
      height: tileSize * 2 + 10, 
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), 
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          mainAxisSpacing: 10, 
          crossAxisSpacing: 10, 
          childAspectRatio: 1, 
        ),
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
              border: Border.all(color: Colors.pink.shade100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tile["icon"], size: 28, color: Colors.pink.shade300),
                const SizedBox(height: 8),
                Text(
                  tile["title"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.2,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
