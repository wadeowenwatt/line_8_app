import 'package:flutter_base/ui/pages/chat/chat_page.dart';
import 'package:flutter_base/ui/pages/member_skills/skill_members_page.dart';
import 'package:flutter_base/ui/pages/my_profile/profile_page.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/team_fund/team_fund_page.dart';
import 'package:flutter_base/ui/pages/weekly_report/weekly_report_page.dart';
import 'package:flutter_base/ui/pages/wiki/wiki_page.dart';
import 'package:get/get.dart';

import '../ui/pages/calendar/calendar_page.dart';
import '../ui/pages/calendar/create_event/create_event_page.dart';
import '../ui/pages/feedback/feedback_page.dart';
import '../ui/pages/list_member/list_member_page.dart';
import '../ui/pages/list_member/member_profile/member_profile_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/request_seminal/request_seminal_page.dart';
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
  static const String feedback = "/feedback";
  static const String memberProfile = "/memberProfile";
  static const String myProfile = "/myProfile";
  static const String calendar = "/calendar";
  static const String requestSeminal = "/requestSeminal";
  static const String createEvent = "/createEvent";
  static const String memberSkills = "/memberSkills";
  static const String teamFund = "/teamFund";
  static const String weeklyReport = "/weeklyReport";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: signUp, page: () => const SignUpPage()),
    GetPage(name: chat, page: () => const ChatPage()),
    GetPage(name: wiki, page: () => const WikiPage()),
    GetPage(name: memberList, page: () => const ListMemberPage()),
    GetPage(name: feedback, page: () => const FeedbackPage()),
    GetPage(name: memberProfile, page: () => const MemberProfilePage()),
    GetPage(name: myProfile, page: () => const ProfilePage()),
    GetPage(name: calendar, page: () => const CalendarPage()),
    GetPage(name: requestSeminal, page: () => const RequestSeminalPage()),
    GetPage(name: createEvent, page: () => const CreateEventPage()),
    GetPage(name: memberSkills, page: () => const MemberSkillsPage()),
    GetPage(name: teamFund, page: () => const TeamFundPage()),
    GetPage(name: weeklyReport, page: () => const WeeklyReportPage()),
  ];
}
