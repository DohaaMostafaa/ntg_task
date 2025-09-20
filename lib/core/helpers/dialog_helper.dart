import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../localization/locale_keys.g.dart';

Future<void> showNetworkErrorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(LocaleKeys.network_error.tr()),
      content: Text(LocaleKeys.check_internet.tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(LocaleKeys.ok.tr(),style: Theme.of(context).textTheme.titleLarge,),
        ),
      ],
    ),
  );
}
