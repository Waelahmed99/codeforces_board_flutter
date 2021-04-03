import 'package:flutter/material.dart';
import 'dart:html';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get handles/problems json files from url.
    var url = window.location.href;
    final Map<String, String> params = Uri.parse(url).queryParameters;
    print(params['handle']);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: Text('Welcome ${params['handle']}'),
        ),
      ),
    );
  }
}
