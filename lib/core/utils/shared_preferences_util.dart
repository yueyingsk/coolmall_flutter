import 'package:shared_preferences/shared_preferences.dart';

/// SharePreference 工具类，使用顶层函数简化调用
/// 内部自动管理 SharedPreferences 实例，无需手动获取单例

class SharedPreferencesUtil {
  /// 内部 SharedPreferences 实例
  SharedPreferences? _prefs;

  /// 初始化 SharedPreferences 实例
  /// 建议在应用启动时调用一次
  Future<void> initSharedPreferences() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// 保存字符串类型数据
  Future<bool> setString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setString(key, value);
  }

  /// 保存整数类型数据
  Future<bool> setInt(String key, int value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setInt(key, value);
  }

  /// 保存布尔类型数据
  Future<bool> setBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setBool(key, value);
  }

  /// 保存浮点类型数据
  Future<bool> setDouble(String key, double value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setDouble(key, value);
  }

  /// 保存字符串列表类型数据
  Future<bool> setStringList(String key, List<String> value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setStringList(key, value);
  }

  /// 读取字符串类型数据
  String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  /// 读取整数类型数据
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  /// 读取布尔类型数据
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  /// 读取浮点类型数据
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  /// 读取字符串列表类型数据
  List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    return _prefs?.getStringList(key) ?? defaultValue;
  }

  /// 删除指定键的数据
  Future<bool> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.remove(key);
  }

  /// 清除所有数据
  Future<bool> clear() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.clear();
  }

  /// 检查是否包含指定键的数据
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// 获取所有键
  Set<String> getKeys() {
    return _prefs?.getKeys() ?? <String>{};
  }
}

final prefsUtil = SharedPreferencesUtil();
/// 使用示例
/// ```dart
/// // 1. 应用启动时初始化（提高第一次调用性能，可选但推荐）
/// await prefsUtil.initSharedPreferences();
/// 
/// // 2. 保存数据（通过预定义的prefsUtil实例调用方法）
/// await prefsUtil.saveString('username', 'test_user');
/// await prefsUtil.saveInt('age', 18);
/// await prefsUtil.saveBool('isLogin', true);
/// await prefsUtil.saveDouble('height', 1.75);
/// await prefsUtil.saveStringList('tags', ['flutter', 'dart', 'mobile']);
/// 
/// // 3. 读取数据
/// String username = prefsUtil.getString('username');
/// int age = prefsUtil.getInt('age');
/// bool isLogin = prefsUtil.getBool('isLogin');
/// double height = prefsUtil.getDouble('height');
/// List<String> tags = prefsUtil.getStringList('tags');
/// 
/// // 4. 其他操作
/// bool hasKey = prefsUtil.containsKey('username');
/// Set<String> allKeys = prefsUtil.getKeys();
/// await prefsUtil.remove('age');
/// await prefsUtil.clear();
/// ```

/// 注意：
/// - prefsUtil是全局唯一实例，直接导入后即可使用
/// - 每个方法内部都有_prefs的空值检查，即使未调用initSharedPreferences也能正常工作
/// - 推荐在应用启动时调用initSharedPreferences，避免第一次使用时的延迟

