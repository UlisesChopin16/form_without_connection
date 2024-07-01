import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageControllerHook extends Hook<PageController> {
  const PageControllerHook();

  @override
  HookState<PageController, PageControllerHook> createState() => _PageControllerHookState();
}

class _PageControllerHookState extends HookState<PageController, PageControllerHook> {
  PageController? _pageController;

  @override
  void initHook() {
    super.initHook();
    _pageController = PageController();
  }

  @override
  PageController build(BuildContext context) => _pageController!;

  @override
  void dispose() {
    // ignore: invalid_use_of_protected_member
    _pageController?.dispose();
    _pageController = null;
    super.dispose();
  }

  @override
  String get debugLabel => 'usePageController';
}

PageController usePageController() => use(const PageControllerHook());
