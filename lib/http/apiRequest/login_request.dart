import 'package:flutterapptest/http/request/base_request.dart';

// 登录请求封装
class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  // 是否需要登录
  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/uapi/user/login";
  }
}
