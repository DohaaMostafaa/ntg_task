import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: isDark ? Colors.white : Colors.black,
      ),
      onPressed: () {
        final router = GoRouter.of(context);
        if (router.canPop()) {
          router.pop();
        } else {
          router.goNamed('home');
        }
      },
    );
  }
}
