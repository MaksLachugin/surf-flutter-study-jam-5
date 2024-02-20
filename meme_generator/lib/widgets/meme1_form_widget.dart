import 'package:flutter/material.dart';

class MemeFormWidget extends StatelessWidget {
  final Function(bool) changeImageLocation;

  final Function() loadFromGallery;

  final Function() share;

  const MemeFormWidget({
    Key? key,
    required this.changeImageLocation,
    required this.loadFromGallery,
    required this.share,
    required this.formKey,
    required this.isLocalImage,
    required this.context,
    required this.urlController,
    required this.textController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool isLocalImage;
  final BuildContext context;
  final TextEditingController urlController;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Switch.adaptive(
                    value: isLocalImage,
                    onChanged: changeImageLocation,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                    onPressed: isLocalImage ? loadFromGallery : null,
                    icon: const Icon(Icons.image),
                    color: Theme.of(context).primaryColor,
                    disabledColor: Colors.black12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                    onPressed: share,
                    icon: const Icon(Icons.share),
                    color: Theme.of(context).primaryColor,
                    disabledColor: Colors.black12,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextFormField(
                enabled: !isLocalImage,
                controller: urlController,
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
              padding: const EdgeInsets.all(2.0),
              child: TextFormField(
                controller: textController,
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
          ],
        ));
  }
}
