import 'dart:io';
import 'package:com.makzan.eco/data/datasource/remote/dio/dio_client.dart';
import 'package:com.makzan.eco/data/datasource/remote/exception/api_error_handler.dart';
import 'package:com.makzan.eco/data/model/body/review_body.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProductDetailsRepo {
  final DioClient? dioClient;
  ProductDetailsRepo({required this.dioClient});

  Future<ApiResponse> getProduct(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.productDetailsUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getReviews(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.productReviewUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCount(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.counterUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSharableLink(String productID) async {
    try {
      final response = await dioClient!.get(AppConstants.socialLinkUri+productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> submitReview(ReviewBody reviewBody, List<File> files, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.submitReviewUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    for(int index=0; index <files.length ; index++) {
      if(files[index].path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'fileUpload[$index]',
          files[index].readAsBytes().asStream(),
          files[index].lengthSync(),
          filename: files[index].path.split('/').last,
        ));
      }
    }
    request.fields.addAll(<String, String>{'product_id': reviewBody.productId!, 'comment': reviewBody.comment!, 'rating': reviewBody.rating!});
    http.StreamedResponse response = await request.send();
    return response;
  }
}