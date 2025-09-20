import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart_item.dart';
import '../cart_cubit/cubit.dart';
import '../cart_cubit/states.dart';

class CartButton extends StatelessWidget {
  final int productId;
  final String title;
  final String category;
  final String image;
  final double price;
  final double size;

  const CartButton({
    super.key,
    required this.productId,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    this.size = 17,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        final isInCart = cubit.isInCart(productId);
        final quantity = cubit.getQuantity(productId);

        return isInCart
            ? Container(
          height: 30.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => cubit.removeItem(productId),
                icon: Icon(Icons.remove, color: AppColors.white, size: size.sp),
              ),
              Text("$quantity",
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () => cubit.addItem(
                  CartItem(
                    productId: productId,
                    title: title,
                    category: category,
                    image: image,
                    price: price,
                    quantity: 1,
                  ),
                ),
                icon: Icon(Icons.add, color: AppColors.white, size: size.sp),
              ),
            ],
          ),
        )
            : Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            onPressed: () => cubit.addItem(
              CartItem(
                productId: productId,
                title: title,
                category: category,
                image: image,
                price: price,
                quantity: 1,
              ),
            ),
            icon: Icon(Icons.add_shopping_cart, color: AppColors.primary, size: size.sp),
          ),
        );
      },
    );
  }
}
