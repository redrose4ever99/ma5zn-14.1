import 'package:com.makzan.eco/data/datasource/remote/dio/dio_client.dart';
import 'package:com.makzan.eco/data/datasource/remote/exception/api_error_handler.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';

class BrandRepo {
  final DioClient? dioClient;
  BrandRepo({required this.dioClient});

  Future<ApiResponse> getBrandList() async {

    try {
      final response = await dioClient!.get(AppConstants.brandUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerWiseBrandList(int sellerId) async {

    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseBrandList}$sellerId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}