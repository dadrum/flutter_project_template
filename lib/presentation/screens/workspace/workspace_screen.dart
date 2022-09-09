import 'package:flutter/material.dart';

class WorkSpaceScreen extends StatelessWidget {
  const WorkSpaceScreen({Key? key}) : super(key: key);

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Work space'),
        ),
        body: const Center(
          child: Text('This is work space'),
        ));
  }
}
