import 'base_request.dart';

// 实现一个测试请求的派生类
class TestRequest extends BaseRequest {
  // 使用的请求方法
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  // 是否需要登录
  @override
  bool needLogin() {
    return false;
  }

  // 请求的uri
  @override
  String path() {
    return 'uapi/test/test';
  }
}
