import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/route/router.dart';

class ListPage1 extends StatefulWidget {
  final String id;

  const ListPage1(this.id, {Key? key}) : super(key: key);

  @override
  State<ListPage1> createState() => _ListPage1State();
}

class _ListPage1State extends State<ListPage1> {
  final List<String> idList = ['a', 'b', 'c'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list page ${widget.id}'),
      ),
      body: ListView.separated(
        itemBuilder: _itemBuilder,
        itemCount: idList.length,
        separatorBuilder: _separatorBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        debugPrint('DetailPage id ${idList[index]}}');
        // pushNamed 和 goNamed打开页面有差别，pushNamed每次都会新增加一个页面入栈，goNamed先查找路由栈中是否有
        //当前页面，如果有直接弹出来并替换，如果没有新建一个页面入栈
        // GoRouter.of(context).pushNamed(
        //   list,
        //   queryParameters: {'id': idList[index]},
        //   pathParameters: {'id': idList[index]},
        // );
        context.goNamed(list, pathParameters: {'id': idList[index]});
      },
      child: ListTile(
        title: Text('id:${idList[index]}'),
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider();
  }
}
