import 'package:go_router/go_router.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/home/presentation/screens/product_details.dart';
import 'route_names.dart';
import '../../features/home/presentation/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: RouteNames.cart,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      name: RouteNames.product,
      builder: (context, state) {
        final productId =int.parse(state.pathParameters['id']!);
        return ProductDetailsScreen(id: productId,);
      },
    ),
  ],
);
