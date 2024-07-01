import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_without_connection/constants/color_manager.dart';
import 'package:form_without_connection/constants/font_manager.dart';
import 'package:form_without_connection/constants/styles_manager.dart';

class ParagraphComponent extends StatelessWidget {
  final String text;
  final Color color;

  const ParagraphComponent({super.key, required this.text, this.color = ColorManager.grey1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: getMediumStyle(
        fontSize: FontSize.s14,
        color: color,
      ),
    ).tr();
  }
}