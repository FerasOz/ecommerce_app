import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/api_endpoints.dart';
import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:ecommerce_app/features/home/data/models/categories_model.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';

class HomeRepo {
  final DioHelper _dioHelper;
  HomeRepo(this._dioHelper);

  Future<Either<String, List<ProductsModel>>> getProducts() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.products,
      );

      if (response.statusCode == 200) {
        return Right(productsModelFromJson(response.data));
      } else {
        return Left("Failed to fetch products");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductsModel>>> getCategoryProducts(String categoryName) async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: "${ApiEndpoints.products}/${ApiEndpoints.getCategory}/$categoryName",
      );

      if (response.statusCode == 200) {
        return Right(productsModelFromJson(response.data));
      } else {
        return Left("Failed to fetch product categories");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

    Future<Either<String, List<String>>> getAllCategories() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: ApiEndpoints.categories,
      );

      if (response.statusCode == 200) {
        List<String> categories = List<String>.from(response.data);
        categories.insert(0, "All");
        return Right(categories);
      } else {
        return Left("Failed to fetch categories");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

}
