import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/repositories/chat_repository.dart';
import 'package:flutter_base/repositories/firestorage_repository.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'blocs/app_cubit.dart';
import 'blocs/setting/app_setting_cubit.dart';
import 'common/app_themes.dart';
import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'network/api_util.dart';
import 'repositories/auth_repository.dart';
import 'repositories/movie_repository.dart';
import 'repositories/user_repository.dart';
import 'router/route_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<MovieRepository>(create: (context) {
          return MovieRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<ChatRepository>(create: (context) {
          return ChatRepositoryImpl();
        }),
        RepositoryProvider<FirestoreRepository>(create: (context) {
          return FirestoreRepositoryImpl();
        }),
        RepositoryProvider<FireStorageRepository>(create: (context) {
          return FireStorageRepositoryImpl();
        })
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final userRepo = RepositoryProvider.of<UserRepository>(context);
            final firestoreRepo = RepositoryProvider.of<FirestoreRepository>(context);
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            final chatRepo = RepositoryProvider.of<ChatRepository>(context);
            return AppCubit(
              firestoreRepo: firestoreRepo,
              authRepo: authRepo,
              chatRepo: chatRepo,
            );
          }),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: GetMaterialApp(
                title: AppConfigs.appName,
                theme: const AppTheme(
                  brightness: Brightness.light,
                  primaryColor: AppColors.primaryLightColor,
                ).themeData(),
                // darkTheme: AppThemes(
                //   isDarkMode: true,
                //   primaryColor: state.primaryColor,
                // ).theme,
                themeMode: state.themeMode,
                initialRoute: RouteConfig.splash,
                getPages: RouteConfig.getPages,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate,
                ],
                locale: state.locale,
                supportedLocales: S.delegate.supportedLocales,
              ),
            );
          },
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
