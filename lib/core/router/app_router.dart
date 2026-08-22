import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/core/design_system/design_system_showcase.dart';
import 'package:duni_app/features/challenges/presentation/presentation.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:duni_app/features/groups/presentation/presentation.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:duni_app/features/home/presentation/presentation.dart';
import 'package:duni_app/features/home/shared/shared.dart';
import 'package:duni_app/features/onboarding/presentation/presentation.dart';
import 'package:duni_app/features/onboarding/shared/shared.dart';
import 'package:duni_app/features/profile/presentation/presentation.dart';
import 'package:duni_app/features/profile/shared/shared.dart';
import 'package:flutter/material.dart';

/// Rota central do app — mapeia os paths declarados nos `*Router` de cada
/// feature (ex.: [OnboardingRouter], [HomeRouter], [GroupsRouter],
/// [ChallengesRouter], [ProfileRouter]) para os widgets de tela. Os
/// `*Router` de feature guardam só as constantes de path; quem conhece os
/// widgets é só este arquivo.
abstract final class AppRouter {
  static const String initialRoute = OnboardingRouter.splashPage;

  static const String designSystemShowcaseRoute = '/design-system';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingRouter.splashPage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: SplashView()),
        );
      case OnboardingRouter.onboardingPage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: OnboardingView()),
        );
      case HomeRouter.homePage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: HomeView()),
        );
      case GroupsRouter.listPage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: GroupsView()),
        );
      case GroupsRouter.chatPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(
          builder: (_) => DuniThemeScope(child: ChatView(group: group)),
        );
      case GroupsRouter.detailsPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(
          builder: (_) =>
              DuniThemeScope(child: GroupDetailsView(group: group)),
        );
      case GroupsRouter.mediaPage:
        final group = settings.arguments as GroupRef;
        return MaterialPageRoute(
          builder: (_) => DuniThemeScope(child: MediaView(group: group)),
        );
      case ChallengesRouter.newChallengePage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: NewChallengeView()),
        );
      case ChallengesRouter.chatPage:
        final challenge = settings.arguments as ChallengeRef;
        return MaterialPageRoute(
          builder: (_) =>
              DuniThemeScope(child: ChallengeChatView(challenge: challenge)),
        );
      case ChallengesRouter.detailPage:
        final challenge = settings.arguments as ChallengeRef;
        return MaterialPageRoute(
          builder: (_) => DuniThemeScope(
            child: ChallengeDetailView(challenge: challenge),
          ),
        );
      case ProfileRouter.profilePage:
        return MaterialPageRoute(
          builder: (_) => const DuniThemeScope(child: ProfileView()),
        );
      case designSystemShowcaseRoute:
        return MaterialPageRoute(
          builder: (_) =>
              const DuniThemeScope(child: DuniDesignSystemShowcase()),
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
