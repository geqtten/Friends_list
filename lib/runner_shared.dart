import 'dart:async';

import '../../../core/utils/logger.dart';
import 'feature/app/logic/app_runner.dart';
import 'feature/initialization/logic/initialization_processor.dart';
import 'feature/initialization/model/dependencies.dart';
import 'feature/initialization/model/initialization_hook.dart';

void _onInitializing(InitializationStepInfo info) {
  final percentage = ((info.step / info.stepsCount) * 100).toInt();
  logger.info(
    'Inited ${info.stepName} in ${info.msSpent} ms | '
    'Progress: $percentage%',
  );
}

/// Callback, called when the initialization process is finished.
void _onInitialized(InitializationResult result) => logger.info(
      'Initialization completed successfully in ${result.msSpent} ms',
    );

/// Callback, called when the initialization process is failed.
void _onError(int step, Object error) => logger.error(
      'Initialization failed on step $step',
      error: error,
    );

/// Callback, called when the initialization process is started.
void _onInit() => logger.info('Initialization started');

/// Run that uses all platforms.
void sharedRun() {
  // Some shared initialization here.
  final hook = InitializationHook.setup(
    onInitializing: _onInitializing,
    onInitialized: _onInitialized,
    onError: _onError,
    onInit: _onInit,
  );
  logger.runLogging(
    () => runZonedGuarded(
      () => AppRunner().initializeAndRun(hook),
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
