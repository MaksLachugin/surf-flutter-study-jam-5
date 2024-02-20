import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator/repository/models/meme.dart';

class MemeImageWidget extends StatelessWidget {
  const MemeImageWidget({
    super.key,
    required this.meme,
  });
  final Meme meme;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return DecoratedBox(
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 200,
              child: DecoratedBox(
                decoration: decoration,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: getImage(
                      meme.images[0].isLocal, meme.images[0].selectedImage),
                ),
              ),
            ),
            Text(
              meme.texts[0],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Impact',
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImage(bool isLocalImage, String? selectedImage) {
    if (selectedImage == null) {
      return const Placeholder();
    }
    return isLocalImage
        ? Image.file(
            File(selectedImage),
            fit: BoxFit.cover,
            errorBuilder: (buildContext, object, stackTrace) =>
                Image.asset("assets/def.jpg", fit: BoxFit.cover),
          )
        : Image.network(
            selectedImage,
            fit: BoxFit.cover,
            errorBuilder: (buildContext, object, stackTrace) =>
                Image.asset("assets/def.jpg", fit: BoxFit.cover),
          );
  }
}
