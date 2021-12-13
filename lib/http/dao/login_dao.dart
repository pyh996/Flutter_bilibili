import 'package:flutterapptest/db/hi_cache.dart';
import 'package:flutterapptest/http/core/hi_net.dart';
import 'package:flutterapptest/http/request/base_request.dart';
import 'package:flutterapptest/http/apiRequest/login_request.dart';
import 'package:flutterapptest/http/apiRequest/registration_request.dart';

class LoginDao {
  // 登录后的令牌
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  // 发送请求
  static _send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    // 添加参数
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId ?? "")
        .add("orderId", orderId ?? "");
    // 发送请求
    var result = await HiNet.getInstance().fire(request);
    print(result);
    // 如果数据存在
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
