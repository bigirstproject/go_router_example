import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String? id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取 query parameters
    debugPrint('DetailPage id $id');
    // debugPrint(
    //     GoRouter.of(context).routerDelegate.currentConfiguration.last.subloc);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Text('id:$id'),
      ),
    );
  }
}
