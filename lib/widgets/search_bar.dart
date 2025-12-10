import 'package:blinkit/common_widgets/blinkit_common_svg.dart';
import 'package:blinkit/resources/app_images.dart';
import 'package:flutter/material.dart';

class BlinkitSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool showMic;

  const BlinkitSearchBar({
    super.key,
    this.hint = 'Search for products...',
    this.onChanged,
    this.showMic = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          BlinkitCommonSVGIcon(
            image: AppImages.blinkitSearch,
            height: 22,
            width: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black45),
              ),
            ),
          ),
          if (showMic) const Icon(Icons.mic_none, color: Colors.black54),
        ],
      ),
    );
  }
}
