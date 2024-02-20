import 'dart:io';

import 'package:flutter/material.dart';

class MemeImageWidget extends StatelessWidget {
  const MemeImageWidget({
    super.key,
    required this.decoration,
    required this.isLocalImage,
    required this.selectedImage,
    required this.urlController,
    required this.textController,
  });

  final BoxDecoration decoration;
  final bool isLocalImage;
  final File? selectedImage;
  final TextEditingController urlController;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
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
                  child: isLocalImage && selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          errorBuilder: (buildContext, object, stackTrace) =>
                              Image.asset("assets/def.jpg", fit: BoxFit.cover),
                          urlController.text,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Text(
              textController.text,
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
}
