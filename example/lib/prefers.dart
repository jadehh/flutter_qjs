/*
 * @File     : prefers.dart
 * @Author   : jade
 * @Date     : 2024/9/5 16:58
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:shared_preferences/shared_preferences.dart';

class Prefers {
  late SharedPreferences? preferences;

  static final Prefers _instance = Prefers._internal();

  static Prefers get instance => _instance;

  factory Prefers() {
    return _instance;
  }

  Prefers._internal(){
  }

  static Prefers get() {
    return _instance;
  }
  init() async{
    preferences = await SharedPreferences.getInstance();

  }

}