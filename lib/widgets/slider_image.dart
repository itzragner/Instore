import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final String image;
  const ImageSlider({
    super.key,
    required this.image,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Hero(
            tag: image,
            child: SizedBox(
              width:double.infinity,
              child: Image.asset(image)),
          );
        },
      ),
    );
  }
}
