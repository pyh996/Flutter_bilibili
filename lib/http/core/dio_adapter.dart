import 'package:dio/dio.dart';
import 'package:flutterapptest/http/core/hi_error.dart';
import 'package:flutterapptest/http/core/hi_net_adapter.dart';
import 'package:flutterapptest/http/request/base_request.dart';

///Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    // 设置请求头部
    var response, options = Options(headers: request.header);
    var error;

    try {
      // 如果是GET请求
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options); // Get请求
        // 如果是POST请求
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(),
            data: request.params, options: options); // Post请求
        // 如果是DELETE请求
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(),
            data: request.params, options: options); // DELETE请求
      }
    } on DioError catch (e) {
      //捕获异常
      error = e;
      response = e.response;
    }
    // 如果存在异常
    if (error != null) {
      ///抛出HiNetError,组装code,message,data数据
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    print(buildRes(response, request));
    // response请求回来的参数, request是request
    return buildRes(response, request);
  }

  // 构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    // 组装数据
    return Future.value(HiNetResponse(
        //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
