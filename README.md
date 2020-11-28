## 简介

使用`Flutter`开发的一款`app`，项目的目的主要是为了`Flutter`的练手学习，该项目覆盖了各种组件或者第三方库的使用，配合自身搭建的后台服务，当然也有部分自定义`UI`组件，目前已经完成基础版本开发，包含一个网站、`app`基本的登录注册，数据展示，数据存储，后续有空会接着完善。有需要可以`clone`运行



## 1.项目的技术介绍

1.1使用`Flutter`完成基本的页面布局以及交互，修改部分原生组件，定制开发部分组件，适配`iOS`和安卓

1.2使用`Nodejs + Koa2 + MongoDB`搭建后台服务，日志记录在`log`目录下

1.3使用`Dio`网络请求库，完成前后端交互



## 2.项目搭建运行流程

2.1配置好`Flutter`开发环境，可参阅 [搭建环境 ](https://flutterchina.club/)

2.2`clone`代码，国内可能需要设置代理: [代理环境变量](https://flutterchina.club/setup-windows/)。

2.3搭建好`Nodejs`以及`MongoDB`环境

2.4`clone`后台`Nodejs`项目，[地址](https://github.com/xtid/footprint-node)，安装好依赖启动

2.5将`Flutter`项目中`main.dart`文件中的`dio.options.baseUrl`地址改成你本地Nodejs服务的`地址+端口/api`

2.6执行`Flutter run`安装第三方包及运行



## 3.其它配置

此项目因为运用到高德地图服务，所以建议你自己去高德开发者平台申请对应的应用，将你申请的`key`替换项目中默认的`key`

#### 3.1iOS配置

首先找到此方法

```dart
Flutter2dAMap.setApiKey('配置你的key');
```

然后在`info.plist`中增加，目的是询问获取定位权限，设置对应的提示

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>地图功能需要您的定位服务，否则无法使用，如果您需要使用后台定位功能请选择“始终允许”。</string>

<key>NSLocationAlwaysUsageDescription</key>
<string>地图功能需要您的定位服务，否则无法使用。</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>地图功能需要您的定位服务，否则无法使用。</string>

<key>io.flutter.embedded_views_preview</key>
<true/>
```

#### 3.2安卓配置

`AndroidManifest.xml `中添加：

```xml
<meta-data
     android:name="com.amap.api.v2.apikey"
     android:value="配置你的key"/>
```


如果你的`targetSdkVersion`为27以上，则需要做以下配置来支持http明文请求，否则会导致地图加载不出：

`AndroidManifest.xml `中添加：

```xml
<application
  android:networkSecurityConfig="@xml/network_security_config"
/>
```

项目中默认已经配置好了，所以你只需简单设置下`key`就行了



## 4.项目运行图

