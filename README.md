# 青商城 Flutter

_🛍️ 基于 Flutter 的现代化电商应用_

<div align="center">

<img src="assets/drawable/ic_logo.svg" width="120" alt="青商城Logo"/>

<!-- 语言切换按钮 -->
<div align="center">
  <a href="README_EN.md">🌍 English</a>
</div>

[![GitHub](https://img.shields.io/badge/GitHub-CoolMallFlutter-blue?style=flat-square&logo=github)](https://github.com/yueyingsk/coolmall_flutter)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=flat-square&logo=android)](https://flutter.dev/docs/deployment)

</div>

## 📖 项目简介

这是一个基于 **Flutter** 打造的现代化电商学习项目，复刻了 [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin) 项目的所有UI设计、交互效果和功能逻辑。

项目采用 Flutter 跨平台特性，**一套代码，多端运行**，支持 Android、iOS 和 Web 平台。本项目严格遵循原项目的设计规范和用户体验，部分还原了界面效果和交互动画。

> **特别致谢**：本项目基于 [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin) 项目进行 Flutter 版本开发，感谢原项目作者提供的优秀设计、UI资源和架构参考！

> 如果项目对您有帮助，请给个 Star 支持 ⭐ 这对Flutter版本的移植工作非常重要！

## 📱 项目预览

> 💡 **说明**：Flutter版本复刻了原项目的所有界面效果和动画

<table>
  <tr>
    <td><img src="docs/images/flutter/1.png" alt="青商城Flutter版1"/></td>
    <td><img src="docs/images/flutter/2.png" alt="青商城Flutter版2"/></td>
    <td><img src="docs/images/flutter/3.png" alt="青商城Flutter版3"/></td>
    <td><img src="docs/images/flutter/4.png" alt="青商城Flutter版4"/></td>
    <td><img src="docs/images/flutter/5.png" alt="青商城Flutter版5"/></td>
  </tr>
</table>

### ☀️ 浅色模式

<img src="docs/images/flutter/light/1.png" alt="青商城Flutter浅色模式1"/>
<img src="docs/images/flutter/light/2.png" alt="青商城Flutter浅色模式2"/>
<img src="docs/images/flutter/light/3.png" alt="青商城Flutter浅色模式3"/>

### 🌙 深色模式

<img src="docs/images/flutter/dark/1.png" alt="青商城Flutter深色模式1"/>
<img src="docs/images/flutter/dark/2.png" alt="青商城Flutter深色模式2"/>
<img src="docs/images/flutter/dark/3.png" alt="青商城Flutter深色模式3"/>

## 🛠️ 技术栈

### 核心技术

| 类别    | 技术选型                      | 版本号     | 说明                   |
|-------|---------------------------|----------|----------------------|
| 编程语言  | Dart                      | 3.x      | 100% Dart 开发        |
| UI 框架 | Flutter                   | 3.19.x   | 跨平台UI框架             |
| 架构模式  | MVVM + Clean Architecture | -        | 响应式架构 + 状态管理       |
| 状态管理  | Provider + ChangeNotifier | -        | Flutter官方推荐状态管理   |
| 路由管理  | GoRouter                  | 14.x     | Flutter官方路由解决方案   |

### 功能模块

| 类别     | 技术选型               | 版本号     | 说明               |
|--------|--------------------|----------|------------------|
| 网络请求  | Dio                | 5.x      | HTTP客户端         |
| 本地存储  | SharedPreferences  | 2.x      | 轻量级键值存储       |
| 图片处理  | cached_network_image | 3.x      | 网络图片缓存         |
| 权限管理  | permission_handler | 11.x     | 动态权限申请         |
| WebView | webview_flutter    | 4.x      | 网页浏览组件         |
| 浏览器打开 | url_launcher       | 6.x      | 外部浏览器打开       |
| 动画效果  | lottie_flutter     | 3.x      | AE动画播放          |

### 开发工具

| 类别   | 技术选型           | 版本号 | 说明           |
|------|----------------|-----|--------------|
| 状态管理 | Provider       | -   | 响应式状态管理     |
| 路由    | GoRouter       | -   | 声明式路由管理     |
| 代码规范 | flutter_lints  | -   | Flutter代码规范   |

## 📚 功能模块目录

> **状态说明：**
> - `✅ 已完成` - 功能页面已完整实现并可以正常使用
> - `🚧 开发中` - 功能页面正在开发中
> - `📋 计划中` - 功能页面尚未开发

### 🎯 核心功能模块

#### 启动流程模块 (launch)
- ✅ 启动页 (splash)
- ✅ 引导页 (guide)

#### 认证模块 (auth)
- 🚧 登录页面 (login)
- 🚧 注册页面 (register)
- 🚧 找回密码 (reset-password)

#### 主页模块 (main)
- ✅ 首页 (home)


#### 商品模块 (goods)
- ✅ 商品分类页面 (goods_category)
- ✅ 商品详情页面 (goods_detail)


#### 通用模块 (common)
- ✅ WebView页面 (web_view)

## 🚀 项目特点

- **跨平台支持**: 一套代码，支持 Android、iOS 和 Web 平台
- **完美复刻**: 100%还原原Kotlin项目的UI设计和交互效果
- **模块化设计**: 采用Clean Architecture，代码结构清晰
- **响应式架构**: Provider状态管理，响应式数据流
- **Material Design**: 严格遵循Material Design设计规范
- **性能优化**: 图片缓存、列表优化、内存管理
- **代码规范**: 遵循Flutter官方代码规范和最佳实践

## 📂 项目结构

```
├── lib/                          # 主代码目录
│   ├── app/                      # 应用核心模块
│   │   ├── bootstrap.dart        # 应用启动入口
│   │   ├── router/               # 路由配置
│   │   │   ├── router.dart       # 主路由
│   │   │   ├── app_routes.dart   # 路由常量
│   │   │   └── routes/           # 各模块路由
│   │   ├── state/                # 应用状态
│   │   └── theme/                # 主题配置
│   │
│   ├── core/                     # 核心模块
│   │   ├── constants/            # 常量定义
│   │   ├── network/              # 网络层
│   │   └── utils/                # 工具类
│   │
│   ├── features/                 # 功能模块
│   │   ├── auth/                 # 认证模块
│   │   ├── main/                 # 主页模块
│   │   ├── goods/                # 商品模块
│   │   ├── common/               # 通用模块
│   │   └── launch/               # 启动模块
│   │
│   ├── shared/                   # 共享组件
│   │   ├── widgets/              # 通用组件
│   │   └── utils/                # 工具方法
│   │
│   └── main.dart                 # 应用入口
│
├── assets/                       # 资源文件
│   ├── drawable/                 # SVG图标
│   └── lottie/                   # Lottie动画
│
├── android/                      # Android配置
├── ios/                          # iOS配置
├── web/                          # Web配置
└── docs/                         # 文档目录
```

## 🔄 对比原Kotlin版本

| 特性对比 | Kotlin版本 | Flutter版本 |
|---------|-----------|------------|
| UI框架  | Jetpack Compose | Flutter Widgets |
| 状态管理 | ViewModel + StateFlow | Provider + ChangeNotifier |
| 路由导航 | Navigation Compose | GoRouter |
| 网络请求 | Retrofit + OkHttp | Dio |
| 权限管理 | XXPermissions | permission_handler |
| 图片加载 | Coil Compose | cached_network_image |
| 动画效果 | Lottie Compose | lottie_flutter |
| WebView | AndroidView (WebView) | webview_flutter |
| 数据存储 | MMKV + Room | SharedPreferences + SQLite |
| 平台支持 | Android | Android + iOS + Web |

## 🎯 开发计划

本项目正在持续开发中，逐步完善各个功能模块：

### 🔧 当前开发重点 (2026年第一季度)

1. **认证系统完善**:
   - 🚧 用户注册功能
   - 🚧 找回密码功能
   - 🚧 短信登录功能

2. **用户体验优化**:
   - 🎨 动画效果完善
   - 📱 响应式布局优化
   - ⚡ 性能调优

3. **功能模块补全**:
   - 🛒 购物车功能完善
   - 👤 用户中心功能
   - 📦 订单管理功能

### 🚀 后续规划 (2026年第二季度)

4. **高级功能**:
   - 💳 支付功能集成
   - 🔔 消息推送
   - 📊 数据分析

5. **平台适配**:
   - 🌐 Web端优化
   - 💻 桌面端支持 (Windows/macOS/Linux)

6. **代码质量**:
   - 🧪 单元测试覆盖
   - 📖 完善文档
   - 🔄 CI/CD流水线

## 🤝 致谢与鸣谢

### 🙏 特别感谢

本项目基于 [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin) 项目进行 Flutter 版本开发，特别感谢：

- **原项目作者**: [Joker-x-dev](https://github.com/Joker-x-dev) 提供了优秀的架构设计和UI设计
- **UI设计**: 完整保留了原项目的所有UI资源和设计规范
- **功能逻辑**: 参考了原项目的完整业务流程和交互逻辑
- **API接口**: 使用了原项目提供的完整API接口文档

### 📚 参考资源

- **原项目地址**: [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin)
- **API文档**: [CoolMall API文档](https://coolmall.apifox.cn)
- **Flutter官方**: [Flutter中文网](https://flutter.cn/)
- **Dart语言**: [Dart中文网](https://www.dartcn.com/)

### 🎨 设计资源

- **图标库**: 基于 [图鸟 Icon](https://github.com/tuniaoTech) 扩展
- **动画效果**: 使用 Lottie 动画，完全复刻原项目效果
- **配色方案**: 严格遵循Material Design 3规范

## 💡 开发理念

- **完美复刻**: 力求100%还原原项目的用户体验
- **Flutter优先**: 充分发挥Flutter跨平台优势
- **性能至上**: 注重应用性能和用户体验
- **代码质量**: 遵循Flutter最佳实践
- **持续迭代**: 根据用户反馈持续改进

## 🔗 相关链接

- **原项目**: [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin)
- **API文档**: [CoolMall接口文档](https://coolmall.apifox.cn)
- **Flutter官网**: [https://flutter.dev](https://flutter.dev)
- **Dart官网**: [https://dart.dev](https://dart.dev)

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源，详见许可证文件。

## 📞 联系方式

- **项目作者**: [yueyingsk](https://github.com/yueyingsk)
- **原项目**: [Joker-x-dev](https://github.com/Joker-x-dev)

---

**让Flutter开发更简单，让跨平台更美好！** 🚀

*本项目是对 [CoolMallKotlin](https://github.com/Joker-x-dev/CoolMallKotlin) 的Flutter版本移植，致力于为Flutter开发者提供一个完整的电商应用学习案例。*