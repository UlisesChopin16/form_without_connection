import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_without_connection/app/extensions.dart';
import 'package:form_without_connection/constants/strings_manager.dart';
import 'package:form_without_connection/presentation/common/state_renderer.dart';
import 'package:go_router/go_router.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
  String getTitle() => empty;
  bool isPopUp() => false;
}

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  LoadingState({
    required this.stateRendererType,
    this.message = StringsManager.loading,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

class SuccessState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  final String title;

  SuccessState({
    required this.stateRendererType,
    required this.message,
    this.title = StringsManager.success,
  }) : super();

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;

  @override
  String getTitle() => title;
}

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  final bool isPop;

  ErrorState({
    required this.stateRendererType,
    required this.message,
    this.isPop = false,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;

  @override
  bool isPopUp() => isPop;
}

class ContentState extends FlowState {
  final bool isPop;
  ContentState({
    this.isPop = false,
  });

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getMessage() => empty;

  @override
  bool isPopUp() => isPop;
}

class EmptyState extends FlowState {
  final String messsage;
  EmptyState({
    required this.messsage,
  });

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;

  @override
  String getMessage() => messsage;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function? retryActionFunction
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() != StateRendererType.POPUP_LOADING_STATE) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage().tr(),
              retryActionFunction: retryActionFunction,
            );
          }
          showPopUp(context, getStateRendererType(), getMessage().tr(), retryActionFunction);
          return contentScreenWidget;
        }
      case ErrorState:
        {
          if (getStateRendererType() != StateRendererType.POPUP_ERROR_STATE) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage().tr(),
              retryActionFunction: retryActionFunction,
            );
          }
          dismissPopUp(context, isPop: true);
          showPopUp(context, getStateRendererType(), getMessage().tr(), retryActionFunction);
          return contentScreenWidget;
        }
      case ContentState:
        {
          print('isPopUp() ${isPopUp()}');
          dismissPopUp(context, isPop: isPopUp());
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage().tr(),
            retryActionFunction: retryActionFunction,
          );
        }
      case SuccessState:
        {
          if (getStateRendererType() != StateRendererType.POPUP_SUCCESS) {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage().tr(),
              retryActionFunction: retryActionFunction,
              title: getTitle().tr(),
            );
          }
          dismissPopUp(context, isPop: true);
          showPopUp(
            context,
            getStateRendererType(),
            getMessage().tr(),
            title: getTitle().tr(),
            retryActionFunction,
          );
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  void dismissPopUp(BuildContext context, {bool isPop = false}) {
    // final stateType = getStateRendererType();
    final bool dialogIsShowing = _isThereCurrentDialogShowing(context);

    if (dialogIsShowing && isPop) {
      context.pop(true);
    }
  }

  // Modal route es una clase que se encarga de manejar las rutas de la aplicación
  // isCurrent es un método que devuelve un booleano si la ruta actual es la que se está mostrando
  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void showPopUp(BuildContext context, StateRendererType stateRendererType, String message,
      Function? retryActionFunction,
      {String title = empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: retryActionFunction,
            title: title,
          );
        },
      );
    });
  }
}
