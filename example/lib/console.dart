/*
 * @File     : console.dart
 * @Author   : jade
 * @Date     : 2024/9/5 16:00
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:flutter_qjs/flutter_qjs.dart';

class Console{
  static const String name = "console";

  static List getInvoke() {
    return [name , {"log": IsolateFunction((String url) {
          print(url);
  }),}];
  }
}