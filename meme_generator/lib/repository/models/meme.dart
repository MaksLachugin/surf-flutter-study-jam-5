import 'package:meme_generator/repository/models/meme_image.dart';

class Meme {
  List<String> texts = List.empty();
  List<MemeImage> images = List.empty();

  Meme({required this.images, required this.texts});

  Meme.first() {
    texts = ['Здесь мог бы быть ваш мем'];

    images = [
      MemeImage(
          isLocal: false,
          selectedImage:
              'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg')
    ];
  }

  Meme.second() {
    texts = ['Здесь мог бы быть ваш мем', 'И тут'];
    images = [
      MemeImage(
          isLocal: false,
          selectedImage:
              'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg')
    ];
  }
}
