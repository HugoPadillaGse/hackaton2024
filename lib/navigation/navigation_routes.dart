import 'package:go_router/go_router.dart';
import 'package:hackaton_2024_mv/feature/principal/presentation/screen/principal_screen.dart';
import 'package:hackaton_2024_mv/navigation/authentication_router.dart';

abstract class NavigationRouters {
  static final List<GoRoute> goRoutes = [
    GoRoute(
      name: PrincipalScreen.name,
      path: PrincipalScreen.link,
      builder: (context, state) => PrincipalScreen(
        onNavLogin: (context) => context.push(AuthenticationRouter.login),
      ),
    )
  ];
}
