import 'package:com.makzan.eco/data/datasource/remote/dio/dio_client.dart';
import 'package:com.makzan.eco/data/datasource/remote/exception/api_error_handler.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';

class WishListRepo {
  final DioClient? dioClient;

  WishListRepo({required this.dioClient});

  Future<ApiResponse> getWishList() async {
    try {
      final response = await dioClient!.get(AppConstants.getWishListUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addWishList(int? productID) async {
    try {
      final response = await dioClient!.post(AppConstants.addWishListUri + productID.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeWishList(int? productID) async {
    try {
      final response = await dioClient!.delete(AppConstants.removeWishListUri + productID.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
