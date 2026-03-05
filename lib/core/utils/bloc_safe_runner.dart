import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../errors/api_error_codes.dart';
import '../errors/app_error.dart';
import '../errors/error_mapper.dart';
import '../logging/app_logger.dart';

typedef EffectEmitter<E> = void Function(E effect);

sealed class GlobalEffect {}

class ForceLogoutEffect extends GlobalEffect {}

class ShowMaintenanceEffect extends GlobalEffect {}

class BlocSafeRunner {
  final AppLogger _logger;

  final _globalEffectController = StreamController<GlobalEffect>.broadcast();

  Stream<GlobalEffect> get globalEffects => _globalEffectController.stream;

  BlocSafeRunner({required AppLogger logger}) : _logger = logger;

  Future<void> run<S, E>({
    required Emitter<S> stateEmitter,
    required EffectEmitter<E> effectEmitter,
    required Future<void> Function() action,
    required S Function(AppError error) onError,
    required E Function(AppError error) errorEffect,
    S? loadingState,
    E? successEffect,
    Map<String, dynamic>? logContext,
  }) async {
    if (loadingState != null) stateEmitter(loadingState);

    try {
      await action();
      if (successEffect != null) effectEmitter(successEffect);
    } catch (e, stackTrace) {
      final appError = ErrorMapper.map(e);

      _logger.error(
        error: appError,
        stackTrace: stackTrace,
        context: logContext,
      );

      if (appError is UnauthorizedError) {
        _globalEffectController.add(ForceLogoutEffect());
        return;
      }

      if (appError is ApiBusinessError &&
          appError.errorCode == ApiErrorCode.maintenanceMode) {
        _globalEffectController.add(ShowMaintenanceEffect());
        return;
      }

      stateEmitter(onError(appError));
      effectEmitter(errorEffect(appError));
    }
  }

  void dispose() => _globalEffectController.close();
}
