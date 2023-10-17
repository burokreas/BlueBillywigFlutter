import 'package:bluebillywig/bluebillywig.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const BbwTest());
}

class BbwTest extends StatelessWidget {
  const BbwTest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluebillywig Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const BbwTestHomePage(title: 'Bluebillywig Test'),
    );
  }
}

class BbwTestHomePage extends StatelessWidget {
  const BbwTestHomePage({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: BlueBillyWigPlayer(
          jsonUrl: 'https://demo.bbvms.com/p/default_standard/c/2431946.json',
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
