import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/repository/models/meme.dart';
import 'package:meme_generator/repository/models/meme_image.dart';

class MemeFormTemplateWidget extends StatefulWidget {
  final Meme meme;
  final void Function(Meme newMeme) call;
  const MemeFormTemplateWidget(
      {super.key, required this.meme, required this.call});

  @override
  State<MemeFormTemplateWidget> createState() => _MemeFormTemplateWidgetState();
}

class _MemeFormTemplateWidgetState extends State<MemeFormTemplateWidget> {
  late ImagePicker picker = ImagePicker();
  late List<TextEditingController> textsControllers;
  late List<TextEditingController> urlControllers;
  late List<bool> isVisibles;
  late List<String> paths;
  late Meme meme;

  _MemeFormTemplateWidgetState();

  @override
  void initState() {
    super.initState();
    meme = widget.meme;
    textsControllers = List.generate(meme.texts.length,
        (index) => TextEditingController(text: meme.texts[index]));
    urlControllers = List.generate(
        meme.images.length,
        (index) => TextEditingController(
            text: !meme.images[index].isLocal
                ? meme.images[index].selectedImage
                : ''));
    paths = List.generate(
        meme.images.length,
        (index) =>
            meme.images[index].isLocal ? meme.images[index].selectedImage : '');
    isVisibles = List.generate(
        meme.images.length, (index) => !meme.images[index].isLocal);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: getComponents(),
      ),
    );
  }

  List<Widget> getComponents() {
    List<Widget> result = [];

    for (final (index, url) in urlControllers.indexed) {
      result.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              enabled: !isVisibles[index],
              controller: url,
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^(http|https):\/\/([\w.]+)+(:[0-9]{1,5})?(\/.*)?$')
                        .hasMatch(value)) {
                  return "Enter correct URL";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'URL',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Switch.adaptive(
              value: !isVisibles[index],
              onChanged: (value) {
                isVisibles[index] = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: IconButton(
              onPressed: isVisibles[index]
                  ? () async {
                      String? path = await loadFromGallery();
                      if (path != null) {
                        paths[index] = path;
                      }
                    }
                  : null,
              icon: const Icon(Icons.image),
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.black12,
            ),
          ),
        ],
      ));

      for (var element in textsControllers) {
        result.add(
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              controller: element,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter text";
                }
                return null;
              },
              // onChanged: setText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
              ),
            ),
          ),
        );
      }
      result.add(IconButton(
          onPressed: () {
            widget.call(genNewMeme());
          },
          icon: const Icon(Icons.upload)));
    }
    return result;
  }

  Future<String?> loadFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return image.path;
  }

  Meme genNewMeme() {
    List<String> texts = List.generate(
        textsControllers.length, (index) => textsControllers[index].text);
    List<MemeImage> images = List.generate(
        urlControllers.length,
        (index) => MemeImage(
            isLocal: isVisibles[index],
            selectedImage:
                isVisibles[index] ? paths[index] : urlControllers[index].text));
    return Meme(images: images, texts: texts);
  }
}
