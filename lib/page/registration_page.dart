import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptest/http/core/hi_error.dart';
import 'package:flutterapptest/http/dao/login_dao.dart';
import 'package:flutterapptest/util/string_util.dart';
import 'package:flutterapptest/util/toast.dart';
import 'package:flutterapptest/widget/appbar.dart';
import 'package:flutterapptest/widget/login_button.dart';
import 'package:flutterapptest/widget/login_effect.dart';
import 'package:flutterapptest/widget/login_input.dart';



class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;

  //
  const RegistrationPage({Key? key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

// 组件状态
class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false; // 是否就可以点击按钮
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId; // 订单的ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("注册", "登录", widget.onJumpToLogin),
        body: Container(
          // 自适应键盘,方式遮挡
          child: ListView(
            children: [
              LoginEffect(protect: protect),
              LoginInput(
                "用户名",
                "请输入用户名",
                onChanged: (text) {
                  userName = text;
                  checkInput();
                },
              ),
              LoginInput(
                "密码",
                "请输入密码",
                obscureText: true,
                // 积极点集中的时候触发
                focusChanged: (focus) {
                  this.setState(() {
                    protect = focus;
                  });
                },
                onChanged: (text) {
                  password = text;
                  print(text);
                  checkInput();
                },
              ),
              LoginInput(
                "确认密码",
                "请再次输入密码",
                lineStretch: true,
                obscureText: true,
                onChanged: (text) {
                  rePassword = text;
                  checkInput();
                },
                focusChanged: (focus) {
                  this.setState(() {
                    protect = focus;
                  });
                },
              ),
              LoginInput(
                "用户ID",
                "请输入用户ID",
                keyboardType: TextInputType.number, // 只能输入数字
                onChanged: (text) {
                  imoocId = text;
                  checkInput();
                },
              ),
              LoginInput(
                "课程订单号",
                "请输入订单号后四位",
                keyboardType: TextInputType.number, // 只能输入数字
                lineStretch: true,
                onChanged: (text) {
                  orderId = text;
                  checkInput();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: LoginButton('注册',
                    enable: loginEnable, onPressed: checkParams),
              )
            ],
          ),
        ));
  }

  // 提交表单,检查数据
  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId?.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    // 发送请求
    send();
  }

  //
  void checkInput() {
    bool enable;
    // 输入框全部有值的时候,才能点击
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      //启用注册按钮
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result =
          await LoginDao.registration(userName!, password!, imoocId!, orderId!);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
//        showToast('注册成功');
        // 跳转
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin!();
        }
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }
}
