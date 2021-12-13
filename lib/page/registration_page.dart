import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptest/widget/appbar.dart';
import 'package:flutterapptest/widget/login_effect.dart';
import 'package:flutterapptest/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

// 组件状态
class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("注册", "登录", () {
          // 右侧按钮的点击事件
          print("click right button");
        }),
        body: Container(
          child: ListView(
            children: [
              LoginEffect(protect: protect),
              LoginInput(
                "用户名",
                "请输入用户名",
                onChanged: (text) {
                  userName = text;
                  print(text);
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
                },
              )
            ],
            // 自适应键盘,方式遮挡
          ),
        ));
  }
}
