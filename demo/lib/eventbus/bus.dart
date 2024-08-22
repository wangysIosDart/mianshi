typedef EventCallback = void Function(dynamic arg);

class EventBus {
  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  factory EventBus() => _instance;

  static final _listeningEvents = <Object, List<EventCallback>?>{};

  //添加订阅者
  static void on(EventType eventName, EventCallback f) {
    _listeningEvents[eventName] ??= <EventCallback>[];
    _listeningEvents[eventName]!.add(f);
  }

  //移除订阅者
  static void off(EventType eventName, [EventCallback? f]) {
    var list = _listeningEvents[eventName];
    if (list == null) return;
    if (f == null) {
      _listeningEvents[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，支持一对多
  static void emit(EventType eventName, {arg}) {
    var list = _listeningEvents[eventName];
    if (list == null) return;
    int len = list.length - 1;
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}


enum EventType {
  // onTokenExpire, // token过期
  onSiteMaintain, // 站点到期
  onAuthRequire, // 需要认证/登录
  onActivityInvalid, // 活动未开启
  onLogin, // 登录
  onLogout, // 注销
  onLogoutForSubDialog, //弹窗页面触发注销限制
  onHandleHref, // 导航
  onTohome,
  onRechargeReload, //刷新充值
  onBindCardSuccess, //绑卡成功
  onGoHomePage, //任意地方返回首页
  onOpenCustomerService, //打开客服
  onYouhuiCenterItemClick, //打开客服
  onGoActivityPage, //任意地方返回TabBar Activity页面
  onUserCenter, //任意地方返回个人中心
  onRefUserCenter, //刷新个人中心
  onChangeTabbarIndex, //进行tabbar切换
  onUpdateProgress, //更新进度条
  onGoInHome, // 进入首页通知
  reflashPoint,
  onIsNotCommon, //非通用版 用于取款未设置信息时点击判断
}