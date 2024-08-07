library tips_generator;

import 'package:navigation_router/navigation_router.dart';
import 'package:provider/provider.dart';
import 'package:tips_generator/modules/leaguetips/presentation/pages/leaguetips_page.dart';

import 'modules/leaguetips/domain/providers/leaguetips_providers.dart';

class TipsGeneratorRouter {
  static List<AppRoute> routes() {
    return [
      AppRoute(
        name: 'LeagueTips',
        path: '/leagueTips',
        builder: (context, _) => const LeagueTipsPage(),
      ),
    ];
  }
}

class TipsGeneratorProviders {
  static List<Provider> providers() {
    return [
      ...LeaguetipsProviders.providers(),
    ];
  }
}
