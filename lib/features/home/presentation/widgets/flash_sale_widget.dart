import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntg_task/features/home/presentation/widgets/product_card.dart';
import 'package:ntg_task/features/home/presentation/widgets/product_shimmer.dart';
import '../../../../core/helpers/dialog_helper.dart';
import '../cubit/home_cubit/cubit.dart';
import '../cubit/home_cubit/states.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        if (state is HomeLoading) {
          return _buildGrid(
            itemCount: 4,
            itemBuilder: (context, index) => const ProductShimmer(),
          );
        }

        if (state is HomeProductsLoaded) {
          return _buildGrid(
            itemCount: cubit.products.length,
            itemBuilder: (context, index) {
              final product = cubit.products[index];
              return ProductCard(product: product,);
            },
          );
        }
        if (state is NetworkError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showNetworkErrorDialog(context,);
          });
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGrid({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
