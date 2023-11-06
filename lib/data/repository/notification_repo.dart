import 'package:dio/dio.dart';
import 'package:com.makzan.eco/data/datasource/remote/dio/dio_client.dart';
import 'package:com.makzan.eco/data/datasource/remote/exception/api_error_handler.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';

class NotificationRepo {
  final DioClient? dioClient;
  NotificationRepo({required this.dioClient});

  Future<ApiResponse>  getNotificationList(int offset) async {
    try {
      Response response = await dioClient!.get('${AppConstants.notificationUri}?limit=10&guest_id=1&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse>  seenNotification(int id) async {
    try {
      Response response = await dioClient!.get('${AppConstants.seenNotificationUri}?id=$id&guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}