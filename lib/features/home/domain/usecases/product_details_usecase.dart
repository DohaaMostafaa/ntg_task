import '../../../../core/networking/api_result.dart';
import '../../data/models/product_model.dart';
import '../repositories/products.dart';

class GetProductDetails {
  final ProductsRepository repository;

  GetProductDetails(this.repository);

  Future<ApiResult<ProductModel>> call(int id) async {
    return await repository.getProductDetails(id);
  }
}
