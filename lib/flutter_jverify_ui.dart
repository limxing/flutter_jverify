class JVUIConfig {
  bool? autoHidden;
  bool? animated;
  int? timeout;

  ///是否隐藏导航栏（适配全屏图片） default:false
  bool? navCustom;

  ///导航栏颜色
  int? navColor;

  ///导航栏标题
  String? navText;

  ///导航返回图标
  String? navReturnImg;

  ///导航栏是否透明，默认不透明。此参数和navBarBackGroundImage冲突，应避免同时使用
  bool? navTransparent;

  ///导航栏默认返回按钮隐藏，默认不隐藏
  bool? navReturnHidden;

  ///导航栏分割线是否隐藏，默认隐藏
  bool? navDividingLineHidden;

  ///导航栏背景图片.此参数和navTransparent冲突，应避免同时使用
  String? navBarBackGroundImage;

  ///状态栏主题
  StatusBarStyle? statusBarStyle;

  Map get json => {
        'autoHidden': autoHidden,
        'animated': animated,
        'timeout': timeout,
        'navColor': navColor,
        'navCustom': navCustom,
        'navText': navText,
        'navReturnImg': navReturnImg,
        'navTransparent': navTransparent,
        'navReturnHidden': navReturnHidden,
        'navDividingLineHidden': navDividingLineHidden,
        'navBarBackGroundImage': navBarBackGroundImage,
        'statusBarStyle': statusBarStyle?.name
      };
}

enum StatusBarStyle { light, dark }
