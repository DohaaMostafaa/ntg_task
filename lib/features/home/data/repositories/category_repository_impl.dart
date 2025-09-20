import 'package:dio/dio.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';
import '../../../../core/networking/network_exceptions.dart';
import '../../domain/repositories/categories.dart';

class CategoriesRepoImpl implements CategoriesRepository {
  Dio dio;
  ApiServices apiServices;

  CategoriesRepoImpl(this.dio, this.apiServices);

  @override
  Future<ApiResult<List<String>>> getAllCategories() async {
    try {
      var response = await apiServices.getCategories();
      return Success(response);
    } catch (error) {
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}