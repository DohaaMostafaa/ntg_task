import 'package:dio/dio.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';
import '../../../../core/networking/network_exceptions.dart';
import '../../domain/repositories/products.dart';
import '../models/product_model.dart';

class ProductRepoImpl implements ProductsRepository {
  Dio dio;
  ApiServices apiServices;

  ProductRepoImpl(this.dio, this.apiServices);

  @override
  Future<ApiResult<List<ProductModel>>> getAllProducts() async {
    try {
      var response = await apiServices.getProducts();
      return Success(response);
    } catch (error) {
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
  @override
  Future<ApiResult<ProductModel>> getProductDetails(int id) async {
    try {
      var response = await apiServices.getProductDetails(id);
      return Success(response);
    } catch (error) {
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}