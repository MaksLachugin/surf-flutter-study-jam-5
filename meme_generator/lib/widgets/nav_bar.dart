import 'package:flutter/material.dart';
import 'package:meme_generator/repository/models/meme_template.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(width: 50),
          ListTile(
            leading: const Icon(Icons.one_k),
            title: const Text('First'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MemeGeneratorScreen(memeTemplete: MemeTemplete.first())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.two_k),
            title: const Text('Second'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MemeGeneratorScreen(
                      memeTemplete: MemeTemplete.second())));
            },
          )
        ],
      ),
    );
  }
}
