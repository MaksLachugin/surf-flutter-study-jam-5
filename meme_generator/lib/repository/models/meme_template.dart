import 'dart:ui';

import 'package:meme_generator/repository/models/meme.dart';
import 'package:meme_generator/repository/models/meme_component_template.dart';

class MemeTemplete {
  List<MemeComponentTemplate> images = List.empty();
  List<MemeComponentTemplate> texts = List.empty();
  Meme? sample;

  MemeTemplete(this.sample, {required this.images, required this.texts});

  MemeTemplete.first() {
    images = [
      MemeComponentTemplate(
          size: const Size(200, 200), pos: const Offset(150, 150))
    ];

    texts = [
      MemeComponentTemplate(
          size: const Size(200, 200), pos: const Offset(150, 400))
    ];
    sample = Meme.first();
  }

  MemeTemplete.second() {
    sample = Meme.second();

    images = [
      MemeComponentTemplate(
          size: const Size(200, 200), pos: const Offset(150, 150))
    ];

    texts = [
      MemeComponentTemplate(
          size: const Size(200, 200), pos: const Offset(150, 400)),
      MemeComponentTemplate(
          size: const Size(200, 200), pos: const Offset(150, 600))
    ];
  }
}
