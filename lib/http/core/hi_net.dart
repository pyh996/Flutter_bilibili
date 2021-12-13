import 'package:flutterapptest/http/core/dio_adapter.dart';
import 'package:flutterapptest/http/core/hi_error.dart';
import 'package:flutterapptest/http/request/base_request.dart';
import 'package:flutterapptest/http/core/hi_net_adapter.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;

  static HiNet getInstance() {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  // 发送请求
  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      // HiNetError 的异常
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }
    //
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    // 解析状态码
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 400:
        throw NeedLogin();
      case 401:
        throw TestLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  //
  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    printLog('methods:${request.httpMethod()}');
    // HiNetAdapter adapter = MockAdapter();   MOCK数据
    HiNetAdapter adapter = DioAdapter(); // DIO 发送请求
    return adapter.send(request);
  }

  void printLog(log) {
    print("hiNet:${log.toString()}");
  }
}
