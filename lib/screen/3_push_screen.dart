import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/layout/defaut_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            /**
             * push 함수
             * Routes를 '/' 하위에 'first', 'second', 'third'가 있다고 가정하면,
             * first로 이동하면 router에 정의된 순서를 무시하고 'first'만 추가됨
             */
            onPressed: () {
              context.push('/basic');
            },
            child: Text('Push Basic'),
          ),
          ElevatedButton(
            /**
             * Go 함수
             * Routes를 '/' 하위에 'first', 'second', 'third'가 있다고 가정하면,
             * first로 이동하면 '/'와 'first'가 추가됨
             * 즉, 화면이 router에 정의된 순서로만 중첩됨
             */
            onPressed: () {
              context.go('/basic');
            },
            child: Text('Go Basic'),
          ),
        ],
      ),
    );
  }
}
