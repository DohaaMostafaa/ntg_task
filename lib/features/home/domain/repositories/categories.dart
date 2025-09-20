import '../../../../core/networking/api_result.dart';

abstract class CategoriesRepository {
  Future<ApiResult<List<String>>> getAllCategories();

}