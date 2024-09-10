/*
 * @Description: example
 * @Author: ekibun
 * @Date: 2020-08-08 08:16:51
 * @LastEditors: ekibun
 * @LastEditTime: 2020-12-02 11:28:06
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'highlight.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'console.dart';
import 'prefers.dart';
import 'local.dart';

void main() async {
  await Prefers.get().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_qjs',
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (BuildContext context) => TestPage(),
      },
      initialRoute: 'home',
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String resp = "";

  late SharedPreferences? prefs;

  CodeInputController _controller =
      CodeInputController(text: 'import cat;var a = "123";console.log(a)');

  _ensureEngine() async {
    var a = 1;
    final qjs = IsolateQjs(
      moduleHandler: (String module) async  {
        if(module == "hello")
          return await rootBundle.loadString("");
        throw Exception("Module Not found");
      },
    );

    try {
      JSInvokable setToGlobalObject = await qjs.evaluate("(key, val) => { this[key] = val; }");

      await setToGlobalObject.invoke(Console.getInvoke());
       setToGlobalObject.free();
      await qjs.evaluate('console.log("hello quickjs");');
      // await qjs.evaluate('local.set("1245");');
      // final a = await qjs.evaluate('local.get();');
      // print(a);
      // qjs.evaluate('console.log(c);');

      // qjs.evaluate(await rootBundle.loadString("js/http.js"));

    } catch (e) {
      print('[JsEngine] Fail to eval script. \n$e');
    } finally {
       qjs.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JS engine test"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                      child: Text("evaluate"),
                      onPressed: () async {
                        await _ensureEngine();

                        setState(() {});
                      }),
                  TextButton(
                      child: Text("reset engine"),
                      onPressed: () async {

                      }),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.withOpacity(0.1),
              constraints: BoxConstraints(minHeight: 200),
              child: TextField(
                  autofocus: true,
                  controller: _controller,
                  decoration: null,
                  expands: true,
                  maxLines: null),
            ),
            SizedBox(height: 16),
            Text("result:"),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green.withOpacity(0.05),
              constraints: BoxConstraints(minHeight: 100),
              child: Text(resp == null ? '' : resp!),
            ),
          ],
        ),
      ),
    );
  }
}
