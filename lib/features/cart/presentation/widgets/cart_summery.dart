import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/default_button.dart';
import '../cart_cubit/cubit.dart';
import '../../domain/entities/cart_item.dart';

class CartSummary extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartSummary({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SummaryRow(
            label: '${LocaleKeys.total.tr()} (${cubit.totalQuantity} ${LocaleKeys.items.tr()})',
            value: formatPrice(cubit.totalPrice),
          ),
          SizedBox(height: 8.h),
          SummaryRow(label: LocaleKeys.shipping_fee.tr(), value: "\$0.00"),
          SizedBox(height: 8.h),
          SummaryRow(label: LocaleKeys.taxes.tr(), value: "\$0.00"),
          Divider(height: 20.h, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.total.tr(), style: textTheme.bodyMedium),
                  Text(formatPrice(cubit.totalPrice), style: textTheme.bodyLarge),
                ],
              ),
              SizedBox(
                width: 150.w,
                child: DefaultButton(
                  title: LocaleKeys.checkout.tr(),
                  onPressed: () => _showCheckoutDialog(context, cubit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartCubit cubit) {
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.confirm_order.tr(), style: textTheme.titleLarge),
          content: Text(
            '${LocaleKeys.order_confirmation_message.tr()} ${formatPrice(cubit.totalPrice)}?',
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.cancel.tr(),
                  style: textTheme.bodyLarge!.copyWith(color: AppColors.primary)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog(context, cubit);
              },
              child: Text(LocaleKeys.confirm.tr(),
                  style: textTheme.bodyLarge!.copyWith(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, CartCubit cubit) {
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.order_successful.tr(), style: textTheme.titleLarge),
          content: Text('${formatPrice(cubit.totalPrice)}',
            style: textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).goNamed('home');
                cubit.clearCart();
              },
              child: Text(LocaleKeys.ok_button.tr(),
                  style: textTheme.bodyLarge!.copyWith(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label), Text(value)],
    );
  }
}

String formatPrice(double price) => '\$${price.toStringAsFixed(2)}';
