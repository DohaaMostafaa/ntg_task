import '../../../data/models/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}
class HomeLoading extends HomeStates {}
class LoadingDetails extends HomeStates {}
class HomeCategoriesLoaded extends HomeStates {
  final List<String> categories;
  HomeCategoriesLoaded(this.categories);
}
class HomeProductsLoaded extends HomeStates {
  final List<ProductModel> products;
  HomeProductsLoaded(this.products);
}
class ProductDetailsLoaded extends HomeStates{
  final ProductModel productDetails;
  ProductDetailsLoaded(this.productDetails);
}
class HomeError extends HomeStates {
  final String message;
  HomeError(this.message);
}
class NetworkError extends HomeStates {}
class ProductDetailsError extends HomeStates {
  final String message;
  ProductDetailsError(this.message);
}
