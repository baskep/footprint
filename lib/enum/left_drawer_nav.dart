class LeftDrawerNav {
  static var icon = const [
    'assets/img/list.png', 'assets/img/account.png', 'assets/img/cookie.png'
  ];
  
  static var text = const [
    '我的足迹', '账户信息', '更多'
  ];
  static var link = const [
    'footprint', 'userEdit', 'moreInfo'
  ];

  static List<dynamic> leftDrawerNavList = [icon, text, link];
}