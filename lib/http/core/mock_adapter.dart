import 'package:flutterapptest/http/core/hi_net_adapter.dart';
import 'package:flutterapptest/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    // 延迟一秒以后返回
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          request: request,
          data: {"code": 0, "message": '这是mock数据'} as T,
          statusCode: 200);
    });
  }
}
