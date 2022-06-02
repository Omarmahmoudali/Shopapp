import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/shared/bloc_observer.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/theme.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding!=null){
    // ignore: unnecessary_null_comparison
    if(token!=null) {
      widget =const ShopLayout();
    } else {
      widget =ShopLoginScreen();
    }
  }else
  {
    widget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool? isDark;
  final Widget startWidget;
  MyApp({
    this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ),),
        BlocProvider( create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home:startWidget,
          );
        },
      ),
    );
  }
}
