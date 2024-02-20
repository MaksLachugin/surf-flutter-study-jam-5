import 'package:flutter/material.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() {
    return _MemeGeneratorScreenState();
  }
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  var visible = true;
  final formKey = GlobalKey<FormState>();
  var url =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  var text = 'Здесь мог бы быть ваш мем';
  TextEditingController urlController = TextEditingController(
      text:
          'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg');
  TextEditingController textController =
      TextEditingController(text: 'Здесь мог бы быть ваш мем');

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
              text = textController.text;
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
              DecoratedBox(
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
                            child: Image.network(
                              loadingBuilder:
                                  (buildContext, object, stackTrace) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                              errorBuilder:
                                  (buildContext, object, stackTrace) =>
                                      Image.asset("assets/def.jpg",
                                          fit: BoxFit.cover),
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
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: textController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter text";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Text',
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
