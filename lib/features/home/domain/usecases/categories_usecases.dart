import '../repositories/categories.dart';
import '../../../../core/networking/api_result.dart';

class GetAllCategories {
  final CategoriesRepository repository;

  GetAllCategories(this.repository);

  Future<ApiResult<List<String>>> call() async {
    return await repository.getAllCategories();
  }
}
