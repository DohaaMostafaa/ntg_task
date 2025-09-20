import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:ntg_task/features/home/presentation/widgets/product_shimmer.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cart/presentation/widgets/add_to_cart_button.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(8.w),
      child: GestureDetector(
        onTap: (){
          context.pushNamed(
            RouteNames.product,
            pathParameters: {'id': product.id.toString()},
          );

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImage(imageUrl: product.image),
                Positioned(
                  bottom: 1.h,
                  right: 5.w,
                  child: CartButton(
                    productId: product.id!,
                    image: product.image!,
                    title: product.title!,
                    price: product.price!,
                    category: product.category!,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              product.title ?? "No Title",
              style: textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            PriceAndRating(price: product.price, rating: product.rating?.rate),
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  const ProductImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Theme.of(context).colorScheme.background,
      ),
      child:
          imageUrl != null
              ? Image.network(
                imageUrl!,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const ProductShimmer();
                },
                errorBuilder:
                    (_, __, ___) => const Icon(Icons.broken_image, size: 40),
              )
              : const Center(child: Icon(Icons.image, size: 40)),
    );
  }
}

class PriceAndRating extends StatelessWidget {
  final double? price;
  final double? rating;
  const PriceAndRating({super.key, this.price, this.rating});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final currentPrice = price ?? 0;
    final oldPrice = currentPrice + currentPrice;
    final rate = (rating ?? 0).toStringAsFixed(1);

    return Row(
      children: [
        Text(
          "\$$currentPrice",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColors.redColor),
        ),
        SizedBox(width: 6.w),
        Text(
          "\$$oldPrice",
          style: textTheme.bodySmall!.copyWith(
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, size: 14, color: AppColors.rateColor),
        Text(rate, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
