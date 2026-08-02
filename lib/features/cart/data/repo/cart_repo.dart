import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/network/api_endpoints.dart';
import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';

class CartRepo {
  final DioHelper _dioHelper;

  CartRepo(this._dioHelper);

  Future<Either<String, CartModel>> getUserCart() async {
    try {
      final response = await _dioHelper.getRequest(
        endPoint: "${ApiEndpoints.carts}/user/2",
      );
      if (response.statusCode == 200) {
        CartModel loginResponse = CartModel.fromJson(response.data[0]);
        return right(loginResponse);
      } else {
        return left(response.toString());
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, CartModel>> addToCart({
    required ProductsModel product,
    required String date,
    required int quantity,
  }) async {
    try {
      final response = await _dioHelper.putRequest(
        endPoint: "${ApiEndpoints.carts}/2",
        data: {
          "user_id": 2,
          "date": date,
          "productId": [
            {"productId": product.id, "quantity": quantity},
          ],
        },
      );
      if (response.statusCode == 200) {
        CartModel loginResponse = CartModel.fromJson(response.data);
        return right(loginResponse);
      } else {
        return left(response.toString());
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
