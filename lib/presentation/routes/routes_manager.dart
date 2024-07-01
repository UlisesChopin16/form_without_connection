import 'package:form_without_connection/presentation/views/register/register_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String registerRoute = "/";
  static const String registerRouteName = "RegisterView";
}

class RoutesManager {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.registerRoute,
      name: Routes.registerRouteName,
      builder: (context, state) {
        return const RegisterView();
      },
    ),
    
  ];
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashView());
//       case Routes.loginRoute:
//         initLoginModule();
//         return MaterialPageRoute(builder: (_) => const LoginView());
//       case Routes.onBoardingRoute:
//         return MaterialPageRoute(builder: (_) => const OnboardingView());
//       case Routes.registerRoute:
//         initRegisterModule();
//         return MaterialPageRoute(builder: (_) => const RegisterView());
//       case Routes.forgotPasswordRoute:
//         initForgotPasswordModule();
//         return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
//       case Routes.mainRoute:
//         initHomeModule();
//         return MaterialPageRoute(builder: (_) => const MainView());
//       case Routes.storeDetailsRoute:
//         initStoreDetailsModule();
//         return MaterialPageRoute(builder: (_) => const StoreDetailsPage());
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//               appBar: AppBar(
//                 title: const Text(
//                   StringsManager.noRouteFound,
//                 ),
//               ),
//               body: const Center(
//                 child: Text(
//                   StringsManager.noRouteFound,
//                 ),
//               ),
//             ));
//   }
// }
