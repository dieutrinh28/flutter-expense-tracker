import 'dart:async';

import 'package:flutter/material.dart';

import '../../modules/auth/presentation/bloc/auth_bloc.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthBloc _bloc;
  late final StreamSubscription _sub;
  AuthNotifier(this._bloc) {
    _sub = _bloc.stream.listen((_) => notifyListeners());
  }

  AuthState get state => _bloc.state;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
