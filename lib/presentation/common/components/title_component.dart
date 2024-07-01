import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_without_connection/constants/color_manager.dart';
import 'package:form_without_connection/constants/font_manager.dart';
import 'package:form_without_connection/constants/styles_manager.dart';

class TitleBoldComponent extends StatelessWidget {
  final String text;
  final Color color;
  const TitleBoldComponent({super.key, this.color = ColorManager.primary, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getBoldStyle(
        fontSize: FontSize.s18,
        color: color,
      ),
    ).tr();
  }
}

class TitleRegularComponent extends StatelessWidget {
  final String text;
  final Color color;
  const TitleRegularComponent({super.key, this.color = ColorManager.primary, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle(
        fontSize: FontSize.s16,
        color: color,
      ),
    ).tr();
  }
}
