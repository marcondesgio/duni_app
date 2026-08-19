import 'package:duni_app/core/design_system/design_system_showcase.dart';
import 'package:duni_app/features/groups/presentation/presentation.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:duni_app/features/home/presentation/presentation.dart';
import 'package:duni_app/features/home/shared/shared.dart';
import 'package:duni_app/features/onboarding/presentation/presentation.dart';
import 'package:duni_app/features/onboarding/shared/shared.dart';
import 'package:flutter/material.dart';

/// Rota central do app — mapeia os paths declarados nos `*Router` de cada
/// feature (ex.: [OnboardingRouter], [HomeRouter], [GroupsRouter]) para os
/// widgets de tela. Os `*Router` de feature guardam só as constantes de
/// path; quem conhece os widgets é só este arquivo.
abstract final class AppRouter {
  static const String initialRoute = OnboardingRouter.splashPage;

  static const String designSystemShowcaseRoute = '/design-system';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingRouter.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case OnboardingRouter.onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case HomeRouter.homePage:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case GroupsRouter.listPage:
        return MaterialPageRoute(builder: (_) => const GroupsView());
      case GroupsRouter.chatPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(builder: (_) => ChatView(group: group));
      case GroupsRouter.detailsPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(
          builder: (_) => GroupDetailsView(group: group),
        );
      case GroupsRouter.mediaPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(builder: (_) => MediaView(group: group));
      case designSystemShowcaseRoute:
        return MaterialPageRoute(
          builder: (_) => const DuniDesignSystemShowcase(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => _UnknownRouteView(routeName: settings.name),
        );
    }
  }
}

class _UnknownRouteView extends StatelessWidget {
  const _UnknownRouteView({required this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Rota não encontrada: $routeName')),
    );
  }
}
