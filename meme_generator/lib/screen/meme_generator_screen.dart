// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/widgets/meme_form_widget.dart';
import 'package:meme_generator/widgets/meme_image_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() {
    return _MemeGeneratorScreenState();
  }
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  File? selectedImage;
  var visible = true;
  final formKey = GlobalKey<FormState>();
  final screenKey = GlobalKey();
  var url =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  var text = 'Здесь мог бы быть ваш мем';
  TextEditingController urlController = TextEditingController(
      text:
          'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg');
  TextEditingController textController =
      TextEditingController(text: 'Здесь мог бы быть ваш мем');
  ImagePicker picker = ImagePicker();
  var isLocalImage = false;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              url = urlController.text;
            });
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.update),
      ),
      body: Center(
        child: ColoredBox(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: screenKey,
                child: MemeImageWidget(
                    decoration: decoration,
                    isLocalImage: isLocalImage,
                    selectedImage: selectedImage,
                    urlController: urlController,
                    textController: textController),
              ),
              MemeFormWidget(
                  changeImageLocation: changeImageLocation,
                  loadFromGallery: loadFromGallery,
                  share: share,
                  formKey: formKey,
                  isLocalImage: isLocalImage,
                  context: context,
                  urlController: urlController,
                  textController: textController),
            ],
          ),
        ),
      ),
    );
  }

  void share() {
    shareImageFromKey(screenKey);
  }

  void changeImageLocation(v) {
    setState(() {
      isLocalImage = v;
    });
  }

  Future loadFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      selectedImage = File(image.path);
    });
  }

  Future<void> shareImageFromKey(GlobalKey key) async {
    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 2.0);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final file = File(
        '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(byteData!.buffer.asUint8List());

    Future.delayed(const Duration(seconds: 0), () async {
      Share.shareXFiles([XFile(file.path)], text: 'Демотиватор');
    });
  }

  void setText(String value) {
    if (value.isNotEmpty) {
      setState(() {
        text = textController.text;
      });
    }
  }
}
