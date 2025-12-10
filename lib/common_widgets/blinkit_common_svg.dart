
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlinkitCommonSVGIcon extends StatelessWidget {
  final String? image;
  final Color? color;
  final double? height;
  final double? width;

const  BlinkitCommonSVGIcon({super.key, this.image, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image!,
      height: height,
      width: width,
      color: color,
      cacheColorFilter: true,
    );
  }
}

class BlinkitCommonPNGIcon extends StatelessWidget {
  final String? image;
  final Color? color;
  final double? height;
  final double? width;

const  BlinkitCommonPNGIcon({super.key, this.image, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image!,
      height: height,
      width: width,
      color: color,
    );
  }
}
