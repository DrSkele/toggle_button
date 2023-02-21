import 'package:flutter/material.dart';
import 'package:toggle_button/toggle_button/toggle_button.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toggle Button Example',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ToggleButton(
          value: _toggle,
          color: Colors.amber,
          selectedColor: Colors.red,
          selectedBorderColor: Colors.amber,
          disabledBorderColor: Colors.black,
          borderRadius: BorderRadius.circular(25),
          onPressed: () {
            setState(() {
              _toggle = !_toggle;
            });
          },
          child: Text('what'),
        ),
      ),
    );
  }
}
