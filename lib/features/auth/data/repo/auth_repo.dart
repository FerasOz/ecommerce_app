import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/api_endpoints.dart';
import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/features/auth/data/models/login_response_model.dart';

class AuthRepo {
  final DioHelper _dioHelper;

  AuthRepo(this._dioHelper);

  Future<Either<String, LoginResponseModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioHelper.postRequest(
        endPoint: ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(
          response.data,
        );
        if (loginResponse.token != null) {
          await sl<StorageHelper>().saveToken(loginResponse.token!);
          return right(loginResponse);
        } else {
          return const Left("Token is null");
        }
      } else {
        return left(response.toString());
      }
    } catch (e) {
      if (e is DioException) {
        return left(e.response.toString());
      }
      return left(e.toString());
    }
  }
}
