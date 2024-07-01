import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const TextButtonComponent({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.titleSmall,
      ).tr(),
    );
  }
}
