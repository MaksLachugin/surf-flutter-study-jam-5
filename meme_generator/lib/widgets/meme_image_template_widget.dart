import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator/repository/models/meme.dart';
import 'package:meme_generator/repository/models/meme_template.dart';

class MemeImageTemplateWidget extends StatelessWidget {
  const MemeImageTemplateWidget(
      {super.key, required this.memeTemplete, required this.meme});

  final MemeTemplete memeTemplete;
  final Meme meme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Stack(
        children: genListComponent(),
      ),
    );
  }

  List<Widget> genListComponent() {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    List<Widget> result = [];
    for (final (index, element) in memeTemplete.images.indexed) {
      result.add(
        Positioned(
          left: element.pos.dx,
          top: element.pos.dy,
          width: element.size.width,
          height: element.size.height,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: getImage(
                  meme.images[index].isLocal, meme.images[index].selectedImage),
            ),
          ),
        ),
      );
    }

    for (final (index, element) in memeTemplete.texts.indexed) {
      result.add(
        Positioned(
          left: element.pos.dx,
          top: element.pos.dy,
          width: element.size.width,
          height: element.size.height,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                meme.texts[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Impact',
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return result;
  }

  Widget getImage(bool isLocalImage, String? selectedImage) {
    if (selectedImage == null) {
      return const Placeholder();
    }
    return isLocalImage
        ? Image.file(
            File(selectedImage),
            fit: BoxFit.cover,
          )
        : Image.network(
            errorBuilder: (buildContext, object, stackTrace) =>
                Image.asset("assets/def.jpg", fit: BoxFit.cover),
            selectedImage,
            fit: BoxFit.cover,
          );
  }
}
