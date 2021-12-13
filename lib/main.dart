import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapptest/db/hi_cache.dart';
import 'package:flutterapptest/http/core/hi_error.dart';
import 'package:flutterapptest/http/core/hi_net.dart';
import 'package:flutterapptest/http/dao/login_dao.dart';
import 'package:flutterapptest/http/request/test_request.dart'; // Add this line.
import 'dart:convert';

import 'package:flutterapptest/module/owner.dart';
import 'package:flutterapptest/page/registration_page.dart';
import 'package:flutterapptest/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 小样',
      theme: ThemeData(
        // 自定义的白色
        primarySwatch: white,
      ),
//      home: const MyHomePage(title: '欢迎来到Flutter的世界~'),
      home: RegistrationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int _counter = 0;

class _MyHomePageState extends State<MyHomePage> {
  int _nums = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiCache.preInit(); // 缓存的初始化
  }

  void _incrementCounter() async {
//    test(); // 测试,忽略
//    test1(); // 测试,忽略
//    test2(); // 测试,忽略
    testLogin(); // 测试,忽略
    // TODO 发送网络请求
//    TestRequest request = new TestRequest();
//    // 请求添加参数
//    // {
//    //    "code": 0,
//    //    "data": {
//    //        "code": 0,
//    //        "method": "GET",
//    //        "requestPrams": "ccccc"
//    //    },
//    //    "msg": "SUCCESS."
//    //}
//    request.add("add", "111").add("bb", "222").add("requestPrams", "ccccc");
//    try {
//      // 请求数据
//      var result = await HiNet.getInstance().fire(request);
//      print(result);
//      // 捕获对应的异常
//    } on NeedAuth catch (e) {
//      print(e);
//    } on NeedLogin catch (e) {
//      print(e);
//    }
//    setState(() {
//      _counter++;
//      _nums++;
//    });
  }

  // 测试函数
  void test() {
    const jsonString =
        "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    //json转map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print('name:${jsonMap['name']}');
    print('url:${jsonMap['url']}');

    // map转Json
    String json = jsonEncode(jsonMap);
    print('json:$json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '这里一个flutter的开始应用,你准备好了么',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              '通往牛逼的道路上,风景差的想让想让人说脏话,但是我们在意的是远方',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 255, 150, 150),
                decoration: TextDecoration.underline, // 下划线
                decorationStyle: TextDecorationStyle.solid, // 下划线样式
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // 实体类序列化测试函数
  void test1() {
    var ownerMap = {
      "name": "伊零Onezero333333",
      "face":
          "http://i2.hdslb.com/bfs/face/1c57a17a7b077ccd19dba58a981a673799b85aef.jpg",
      "fans": 0
    };
    Owner owner = Owner.fromJson(ownerMap);
    print('name:${owner.name}');
    print('fans:${owner.fans}');
    print('face:${owner.face}');
  }

  // 测试数据的缓存
  void test2() {
    HiCache.getInstance().setString("aaa", "1234");
    var value = HiCache.getInstance().get("aaa");
    print("value:$value");
  }

  // 测试注册或者登录请求
  void testLogin() async {
    try {
//      var result = await LoginDao.registration(
//          "peiyahui", "psk120515", "6650317", "4527");
      var result = await LoginDao.login("peiyahui", "psk120515");
      print("APIresult$result");
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
