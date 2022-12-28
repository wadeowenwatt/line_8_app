import 'package:flutter_base/ui/pages/chat/chat_page.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/wiki/wiki_page.dart';
import 'package:get/get.dart';

import '../ui/pages/list_member/list_member_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/sign_up/sign_up_page.dart';
import '../ui/pages/splash/splash_page.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String main = "/main";
  static const String signIn = "/signIn";
  static const String wiki = "/wiki";
  static const String chat = "/chat";
  static const String signUp = "/signUp";
  static const String memberList = "/members";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: signUp, page: () => const SignUpPage()),
    GetPage(name: chat, page: () => const ChatPage()),
    GetPage(name: wiki, page: () => const WikiPage()),
    GetPage(name: memberList, page: () => const ListMemberPage()),
  ];
}
