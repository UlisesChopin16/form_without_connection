import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormHook extends Hook<GlobalKey<FormState>> {
  const FormHook();

  @override
  // ignore: library_private_types_in_public_api
  _RefreshHookState createState() => _RefreshHookState();
}

class _RefreshHookState
    extends HookState<GlobalKey<FormState>, FormHook> {
  GlobalKey<FormState>? _key;

  @override
  void initHook() {
    super.initHook();
    _key = GlobalKey<FormState>();
  }

  @override
  GlobalKey<FormState> build(BuildContext context) => _key!;

  @override
  void dispose() {
    // ignore: invalid_use_of_protected_member
    _key?.currentState?.dispose();
    _key = null;
    super.dispose();
  }

  @override
  String get debugLabel => 'useFormStateKey';
}

GlobalKey<FormState> useFormStateKey() =>
    use(const FormHook());
