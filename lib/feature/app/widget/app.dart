import 'package:flutter/material.dart';
import 'package:friends_list/core/widget/scope_widgets.dart';

import '../../initialization/model/dependencies.dart';
import '../../initialization/widget/dependencies_scope.dart';
import 'app_context.dart';

class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  void run() => runApp(this);

  /// Handles initialization result.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => ScopesProvider(
        providers: [
          ScopeProvider(
            buildScope: (child) => DependenciesScope(
              dependencies: result.dependencies,
              child: child,
            ),
          ),
        ],
        child: const AppContext(),
      );
}
