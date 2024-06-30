import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/observer.dart';
import '../../../core/utils/logger.dart';
import '../../initialization/logic/initialization_processor.dart';
import '../../initialization/logic/initialization_steps.dart';
import '../../initialization/model/initialization_hook.dart';
import '../widget/app.dart';

class AppRunner with InitializationSteps, InitializationProcessor {
  /// run initialization
  ///
  /// if success -> run app
  Future<void> initializeAndRun(InitializationHook hook) async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();
    FlutterError.onError = logger.logFlutterError;
    PlatformDispatcher.instance.onError = logger.logPlatformDispatcherError;
    Bloc.observer = AppBlocObserver();

    // Splash screen test
    //
    // Future initialization(BuildContext ctx) async {
    //   await Future.delayed(const Duration(seconds: 10));
    // }

    // FlutterNativeSplash.removeAfter(initialization);

    final result = await processInitialization(
      steps: initializationSteps,
      hook: hook,
    );
    bindings.addPostFrameCallback((_) => bindings.allowFirstFrame());

    // Run application
    App(result: result).run();
  }
}
