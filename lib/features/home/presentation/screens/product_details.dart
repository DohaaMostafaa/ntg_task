import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ntg_task/core/theme/app_colors.dart';
import 'package:ntg_task/core/widgets/default_button.dart';
import 'package:ntg_task/features/cart/domain/entities/cart_item.dart';
import 'package:ntg_task/features/cart/presentation/cart_cubit/cubit.dart';
import 'package:ntg_task/features/home/presentation/cubit/home_cubit/cubit.dart';
import 'package:ntg_task/features/home/presentation/cubit/home_cubit/states.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helpers/dialog_helper.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../domain/usecases/categories_usecases.dart';
import '../../domain/usecases/product_details_usecase.dart';
import '../../domain/usecases/products_usecases.dart';
import '../widgets/product_details_widget.dart';
import '../widgets/product_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        sl<GetAllCategories>(),
        sl<GetProductDetails>(),
        sl<GetAllProducts>(),
      )..getDetails(id),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (state is LoadingDetails) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            );
          }
          if (state is NetworkError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showNetworkErrorDialog(context,);
            });
          }

          final product = HomeCubit.get(context).productDetails;
          if (product == null) {
            return const Scaffold(body: Center(child: Text('No Product Found')));
          }

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  ProductImageSection(product: product),
                  Expanded(child: ProductDetailsSection(product: product)),
                  AddToCartButton(product: product),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final dynamic product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        width: 200.w,
        height: 40.h,
        child: DefaultButton(
          title: LocaleKeys.add_to_cart.tr(),
          onPressed: () async {
            final cartCubit = CartCubit.get(context);
            cartCubit.addItem(
              CartItem(
                productId: product.id ?? 0,
                title: product.title ?? '',
                category: product.category ?? '',
                image: product.image ?? '',
                price: product.price ?? 0,
                quantity: 1,
              ),
            );
            await cartCubit.loadCartFromDB();
            GoRouter.of(context).goNamed('cart');
          },
        ),
      ),
    );
  }
}
