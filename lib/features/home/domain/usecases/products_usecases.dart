import '../../../../core/networking/api_result.dart';
import '../../data/models/product_model.dart';
import '../repositories/products.dart';

class GetAllProducts {
  final ProductsRepository repository;

  GetAllProducts(this.repository);

  Future<ApiResult<List<ProductModel>>> call() async {
    return await repository.getAllProducts();
  }
}