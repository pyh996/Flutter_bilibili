import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapptest/util/color.dart';

///登录输入框，自定义widget
class LoginInput extends StatefulWidget {
  final String title;
  final String hint; // 提示文案
  final ValueChanged<String>? onChanged; // 内容发生变化的时候
  final ValueChanged<bool>? focusChanged; // 焦点
  final bool lineStretch; // 下划线
  final bool obscureText; // 密码输入模式
  final TextInputType? keyboardType; // 输入框的类型

  // 构造方法,默认初始值
  const LoginInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

// 组件状态
class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); // 输入框焦点是否被获取

  @override
  void initState() {
    super.initState();
    //是否获取光标的监听
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      // 发生变化的时候,是不是为空
      if (widget.focusChanged != null) {
        // 不为空的情况下,获取焦点
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  // 页面销毁的时候
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // 组件布局样式
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
            padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
            child: Divider(
              height: 1,
              thickness: 0.5,
            ))
      ],
    );
  }

  // 输入框
  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      // 设置字体的样式
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      // 设置输入框的样式
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, right: 20), // 左右编辑
        border: InputBorder.none, // 不设置边框
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    ));
  }
}
