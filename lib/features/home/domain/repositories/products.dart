import '../../../../core/networking/api_result.dart';
import '../../data/models/product_model.dart';

abstract class ProductsRepository {
  Future<ApiResult<List<ProductModel>>> getAllProducts();
  Future<ApiResult<ProductModel>> getProductDetails(int id);
}