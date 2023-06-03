import 'package:flutter/material.dart';
import 'package:go_router_v7_actual/router/router.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // router 사용
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
