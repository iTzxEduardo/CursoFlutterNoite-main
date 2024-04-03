import 'package:flutter/material.dart';

import 'View.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo SQLlite",
      theme: ThemeData(primarySwatch: Colors.blue),
      home:HomePage(),
    );
    
  }
}