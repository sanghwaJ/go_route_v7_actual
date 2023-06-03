import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/layout/defaut_layout.dart';

class PathParamScreen extends StatelessWidget {
  const PathParamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          // GoRouter의 상태 가져오기 => GoRouterState.of(context)
          Text('Path Param : ${GoRouterState.of(context).pathParameters}'),
          ElevatedButton(
            onPressed: () {
              context.go('/path_param/456/codefactory');
            },
            child: Text(
              'Path Param',
            ),
          ),
        ],
      ),
    );
  }
}
