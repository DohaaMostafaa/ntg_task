import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../cart_cubit/cubit.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_summery.dart';
import 'network_image_widget.dart';

class CartItemRow extends StatelessWidget {
  final CartItem item;

  const CartItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 120.w,
          height: 120.h,
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.lightGrey,
          ),
          child: NetworkImageWithPlaceholder(
            imageUrl: item.image,
            width: 120.w,
            height: 120.h,
            borderRadius: BorderRadius.circular(15.r),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.category, style: textTheme.bodySmall),
              SizedBox(height: 4.h),
              Text(
                item.title,
                style: textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  QuantityButton(
                    icon: Icons.remove,
                    onTap: () => cubit.removeItem(item.productId),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text('${item.quantity}', style: textTheme.bodyLarge),
                  ),
                  QuantityButton(
                    icon: Icons.add,
                    onTap: () => cubit.addItem(item),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    formatPrice(item.price * item.quantity),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18),
        onPressed: onTap,
      ),
    );
  }
}


