import 'package:com.makzan.eco/data/datasource/remote/dio/dio_client.dart';
import 'package:com.makzan.eco/data/datasource/remote/exception/api_error_handler.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';

class HomeCategoryProductRepo {
  final DioClient? dioClient;
  HomeCategoryProductRepo({required this.dioClient});

  Future<ApiResponse> getHomeCategoryProductList() async {
    try {
      final response = await dioClient!.get(
        AppConstants.homeCategoryProductUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}