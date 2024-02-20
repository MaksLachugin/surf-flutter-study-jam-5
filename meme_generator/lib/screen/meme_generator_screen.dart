// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_generator/repository/models/meme.dart';
import 'package:meme_generator/repository/models/meme_template.dart';
import 'package:meme_generator/widgets/meme_form_template_widget.dart';
import 'package:meme_generator/widgets/meme_image_template_widget.dart';
import 'package:meme_generator/widgets/nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatefulWidget {
  final MemeTemplete memeTemplete;
  const MemeGeneratorScreen({Key? key, required this.memeTemplete})
      : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() {
    return _MemeGeneratorScreenState();
  }
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  final formKey = GlobalKey<FormState>();
  final screenKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    MemeTemplete memeTemplete = widget.memeTemplete;

    Meme meme = memeTemplete.sample!;
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                child: MemeImageTemplateWidget(
                  memeTemplete: memeTemplete,
                  meme: meme,
                ),
              ),
              MemeFormTemplateWidget(
                meme: meme,
                call: (Meme newMeme) {
                  setState(() {
                    meme = newMeme;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void share() {
    shareImageFromKey(screenKey);
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
}
