import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/cart/data/local/local_db.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/cart_usecases.dart';
import '../../features/home/data/repositories/category_repository_impl.dart';
import '../../features/home/data/repositories/product_repository_impl.dart';
import '../../features/home/domain/repositories/categories.dart';
import '../../features/home/domain/repositories/products.dart';
import '../../features/home/domain/usecases/categories_usecases.dart';
import '../../features/home/domain/usecases/product_details_usecase.dart';
import '../../features/home/domain/usecases/products_usecases.dart';
import '../networking/api_constants.dart';
import '../networking/api_services.dart';
import '../networking/dio_factory.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Database
  sl.registerLazySingleton<LocalDatabase>(() => LocalDatabase());

  // Cart Feature
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl<LocalDatabase>()),
  );

  // Cart Use Cases
  sl.registerLazySingleton(() => GetAllCartItems(sl()));
  sl.registerLazySingleton(() => AddCartItem(sl()));
  sl.registerLazySingleton(() => UpdateCartItem(sl()));
  sl.registerLazySingleton(() => DeleteCartItem(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));

  // Dio
  sl.registerLazySingleton<Dio>(() => DioFactory.createDio());

  // ApiServices
  sl.registerLazySingleton<ApiServices>(
    () => ApiServices(sl<Dio>(), baseUrl: ApiConstants.apiBaseUrl),
  );

  // Products
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductRepoImpl(sl<Dio>(), sl<ApiServices>()),
  );
  sl.registerLazySingleton<GetAllProducts>(
    () => GetAllProducts(sl<ProductsRepository>()),
  );

  sl.registerLazySingleton<GetProductDetails>(
    () => GetProductDetails(sl<ProductsRepository>()),
  );

  // Categories
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepoImpl(sl<Dio>(), sl<ApiServices>()),
  );
  sl.registerLazySingleton<GetAllCategories>(
    () => GetAllCategories(sl<CategoriesRepository>()),
  );
}
