import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntg_task/core/localization/locale_keys.g.dart';
import '../../../../core/widgets/arrow_widget.dart';
import '../cart_cubit/cubit.dart';
import '../cart_cubit/states.dart';
import '../widgets/cart_item.dart';
import '../widgets/cart_summery.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.bag.tr()),
        centerTitle: true,
        leading: BackArrow(),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(child: Text(state.message));
          }

          final cubit = CartCubit.get(context);
          final cartItems = cubit.cartItemsList;

          if (cartItems.isEmpty) {
            return Center(child: Text(LocaleKeys.cart_is_empty.tr()));
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, index) {
                      return CartItemRow(item: cartItems[index]);
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CartSummary(cartItems: cartItems),
              ],
            ),
          );
        },
      ),
    );
  }
}

