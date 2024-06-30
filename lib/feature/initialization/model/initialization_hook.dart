import 'package:friends_list/feature/initialization/logic/initialization_processor.dart';

import 'dependencies.dart';

abstract interface class InitializationHook {
  InitializationHook({
    this.onInit,
    this.onInitializing,
    this.onInitialized,
    this.onError,
  });

  factory InitializationHook.setup({
    void Function()? onInit,
    void Function(InitializationStepInfo info)? onInitializing,
    void Function(InitializationResult)? onInitialized,
    void Function(int, Object error)? onError,
  }) = _Hook;

  void Function()? onInit;

  void Function(InitializationStepInfo info)? onInitializing;

  void Function(InitializationResult)? onInitialized;

  void Function(int, Object error)? onError;
}

final class _Hook extends InitializationHook {
  _Hook({
    super.onInit,
    super.onInitializing,
    super.onInitialized,
    super.onError,
  });
}
