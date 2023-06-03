import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/layout/defaut_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              // pop 함수 안에 String, int, List, Class 등을 담아 값을 전달할 수 있음
              context.pop('code factory');
            },
            child: Text('Pop'),
          ),
        ],
      ),
    );
  }
}
