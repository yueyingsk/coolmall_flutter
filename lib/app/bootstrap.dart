
import 'package:coolmall_flutter/core/utils/shared_preferences_util.dart';

class Bootstrap {
  static Future<void> initialize() async {
    // 初始化依赖项
    // 例如：初始化 Dio
    // 初始化存储
    // 初始化其他服务
    await prefsUtil.initSharedPreferences();
  }
}