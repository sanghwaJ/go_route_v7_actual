import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screen/10_transition_screen_1.dart';
import 'package:go_router_v7_actual/screen/10_transition_screen_2.dart';
import 'package:go_router_v7_actual/screen/11_error_screen.dart';
import 'package:go_router_v7_actual/screen/1_basic_screen.dart';
import 'package:go_router_v7_actual/screen/3_push_screen.dart';
import 'package:go_router_v7_actual/screen/4_pop_base_screen.dart';
import 'package:go_router_v7_actual/screen/5_pop_return_screen.dart';
import 'package:go_router_v7_actual/screen/6_path_param_screen.dart';
import 'package:go_router_v7_actual/screen/7_query_parameter_screen.dart';
import 'package:go_router_v7_actual/screen/8_nested_child_screen.dart';
import 'package:go_router_v7_actual/screen/8_nested_screen.dart';
import 'package:go_router_v7_actual/screen/9_login_screen.dart';
import 'package:go_router_v7_actual/screen/9_private_screen.dart';
import 'package:go_router_v7_actual/screen/root_screen.dart';

// true => 로그인 OK / false => 로그인 NO
bool authState = false;

final router = GoRouter(
  // state = GoRouterState
  // 맨 위에 적용한 redirect는 전체 route에 적용됨
  redirect: (context, state) {
    if (state.location == '/login/private' && !authState) {
      // return String(path) => 해당 route로 이동
      return '/login';
    } else {
      // return null => 원래 이동하려던 route로 이동
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        GoRoute(
          path: 'basic', // '/basic'
          builder: (context, state) {
            return BasicScreen();
          },
        ),
        GoRoute(
          path: 'named', // '/named'
          name: 'named_screen',
          builder: (context, state) {
            return BasicScreen();
          },
        ),
        GoRoute(
          path: 'push', // '/push'
          builder: (context, state) {
            return PushScreen();
          },
        ),
        GoRoute(
          path: 'pop', // '/pop'
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: 'return', // '/pop/return'
              builder: (context, state) {
                return PopReturnScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id', // '/path_param/{id}'
          builder: (context, state) {
            return PathParamScreen();
          },
          routes: [
            GoRoute(
              path: ':name', // '/path_param/{id}/{name}'
              builder: (context, state) {
                // path가 달라도, 같은 Screen을 반환할 수 있음
                // 즉, 어떤 위젯을 리턴하는지는 중요하지 않으며, 독립적인 위젯으로 봄
                // (사실 지금 예시와 같이 실무에선 잘 쓰진 않음)
                return PathParamScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'query_param', // '/query_param'
          builder: (context, state) {
            return QueryParameterScreen();
          },
        ),
        // ShellRoute => Tab 할 때마다 새로운 router로 이동
        ShellRoute(
          builder: (context, state, child) {
            // child는 아래의 routes에서 값을 받아서 옴
            return NestedScreen(child: child);
          },
          routes: [
            GoRoute(
              path: 'nested/a', // '/nested/a'
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/a',
              ),
            ),
            GoRoute(
              path: 'nested/b', // '/nested/b'
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/b',
              ),
            ),
            GoRoute(
              path: 'nested/c', // '/nested/c'
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/c',
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'login', // '/login'
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private', // '/login/private'
              builder: (_, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2', // '/login2'
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private', // '/login2/private'
              builder: (_, state) => PrivateScreen(),
              /**
               * 한 route 아래에 적용한 redirect는 여기에만 적용됨
               */
              redirect: (context, state) {
                if (!authState) {
                  return '/login2';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
        GoRoute(
          path: 'transition', // '/transition'
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail', // '/transition/detail'
              pageBuilder: (_, state) => CustomTransitionPage(
                // transition이 작동되는 시간
                transitionDuration: Duration(seconds: 3),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // animation => 화면 전환이 될 때, 시작이 0 끝이 1
                  // secondaryAnimation => animation의 반대 방향 (시작이 1, 끝이 0)
                  // child => 여기서는 TransitionScreenTwo
                  // 종류는 FadeTransition, ScaleTransition 등이 있으니 찾아보자
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: TransitionScreenTwo(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  // go route 에러 처리
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  // go route 로깅
  debugLogDiagnostics: true,
);
