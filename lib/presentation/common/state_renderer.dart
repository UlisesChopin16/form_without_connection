// ignore_for_file: constant_identifier_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_without_connection/app/extensions.dart';
import 'package:form_without_connection/constants/assets_manager.dart';
import 'package:form_without_connection/constants/color_manager.dart';
import 'package:form_without_connection/constants/font_manager.dart';
import 'package:form_without_connection/constants/strings_manager.dart';
import 'package:form_without_connection/constants/styles_manager.dart';
import 'package:form_without_connection/constants/values_manager.dart';
import 'package:form_without_connection/data/network/failures/failure.dart';
import 'package:form_without_connection/presentation/common/components/animated_image_component.dart';
import 'package:form_without_connection/presentation/common/components/dialog_component.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    required this.retryActionFunction,
    Failure? failure,
    String? message,
    String? title,
  })  : message = message ?? StringsManager.loading,
        title = title ?? empty;

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.POPUP_ERROR_STATE:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.error),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
              buttonTitle: StringsManager.ok.tr(),
            ),
          ],
        );
      case StateRendererType.POPUP_SUCCESS:
        return DialogComponent(
          children: [
            const AnimatedImageComponent(animationName: JsonAssets.success),
            _getMessage(title),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
              buttonTitle: StringsManager.ok.tr(),
            )
          ],
        );
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.error),
            _getMessage(message),
            RetryButton(
              stateRendererType: stateRendererType,
              retryActionFunction: retryActionFunction,
            )
          ],
        );
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
          [
            const AnimatedImageComponent(animationName: JsonAssets.empty),
            _getMessage(message),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ).tr(),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class RetryButton extends StatelessWidget {
  const RetryButton({
    super.key,
    required this.stateRendererType,
    required this.retryActionFunction,
    this.buttonTitle = StringsManager.retryAgain,
  });

  final String buttonTitle;
  final StateRendererType stateRendererType;
  final Function? retryActionFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
            onPressed: () {
              retryActionFunction?.call(); // to call the API function again to retry
            },
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ).tr(),
          ),
        ),
      ),
    );
  }
}
