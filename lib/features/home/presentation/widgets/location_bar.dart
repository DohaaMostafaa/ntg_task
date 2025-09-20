import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing_helper.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/default_button.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            _locationIcon(context),
            horizontalSpace(10.w),
            _locationText(textTheme),
            const Spacer(),
             DefaultButton(title: LocaleKeys.change.tr(),onPressed:() {},),
          ],
        ),
      ),
    );
  }
}

Widget _locationIcon(BuildContext context) {
  return CircleAvatar(
    radius: 18.r,
    backgroundColor: Theme.of(context).colorScheme.background,
    child: const Icon(Icons.location_on_outlined, color: AppColors.black),
  );
}

Widget _locationText(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(LocaleKeys.send_to.tr(), style: textTheme.bodySmall),
      Text(LocaleKeys.egypt_cairo.tr(), style: textTheme.bodyMedium),
    ],
  );
}
