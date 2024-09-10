/*
 * @File     : local.dart
 * @Author   : jade
 * @Date     : 2024/9/5 16:57
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:flutter_qjs_example/prefers.dart';

class Local{
  static String name = "local";
  static Future set(String name,String str) async {
    await Prefers.get().preferences!.setString(name,str);
  }

  static Future<String?> get(String name) async {
    return await Prefers.get().preferences!.getString("cache");
  }

  static List getInvoke() {
    return [name , {"set":set, "get":get,}];
  }
}
