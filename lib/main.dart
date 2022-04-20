import 'package:abdallah_api/layout/news_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/shop_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/shop_app/shop_layout.dart';
import 'package:abdallah_api/layout/todo_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/todo_app/cubit/states.dart';
import 'package:abdallah_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdallah_api/shared/bloc_observer.dart';
import 'package:abdallah_api/shared/network/local/cache_helper.dart';
import 'package:abdallah_api/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/components/constant.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  // bool? isDark = CacheHelper.getDate(key: 'isDark');
  token = CacheHelper.getDate(key: 'token');

  if (token != null)
    widget = ShopLayout();
  else
    widget = ShopLoginScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.deepOrange,
    //     scaffoldBackgroundColor: Colors.white,
    //     appBarTheme: AppBarTheme(
    //       titleSpacing: 20.0,
    //       systemOverlayStyle: SystemUiOverlayStyle(
    //         statusBarColor: Colors.white,
    //         statusBarIconBrightness: Brightness.dark,
    //       ),
    //       backgroundColor: Colors.white,
    //       elevation: 0.0,
    //       titleTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: 20.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       iconTheme: IconThemeData(
    //         color: Colors.black,
    //       ),
    //     ),
    //     floatingActionButtonTheme: FloatingActionButtonThemeData(
    //       backgroundColor: Colors.deepOrange,
    //     ),
    //     bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //       type: BottomNavigationBarType.fixed,
    //       selectedItemColor: Colors.deepOrange,
    //       unselectedItemColor: Colors.grey,
    //       elevation: 20.0,
    //       backgroundColor: Colors.white,
    //     ),
    //     textTheme: TextTheme(
    //       bodyText1: TextStyle(
    //         fontSize: 18.0,
    //         fontWeight: FontWeight.w600,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   // darkTheme: ThemeData(
    //   //   primarySwatch: Colors.deepOrange,
    //   //   scaffoldBackgroundColor: HexColor('333739'),
    //   //   appBarTheme: AppBarTheme(
    //   //     titleSpacing: 20.0,
    //   //     backwardsCompatibility: false,
    //   //     systemOverlayStyle: SystemUiOverlayStyle(
    //   //       statusBarColor: HexColor('333739'),
    //   //       statusBarIconBrightness: Brightness.light,
    //   //     ),
    //   //     backgroundColor: HexColor('333739'),
    //   //     elevation: 0.0,
    //   //     titleTextStyle: TextStyle(
    //   //       color: Colors.white,
    //   //       fontSize: 20.0,
    //   //       fontWeight: FontWeight.bold,
    //   //     ),
    //   //     iconTheme: IconThemeData(
    //   //       color: Colors.white,
    //   //     ),
    //   //   ),
    //   //   floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   //     backgroundColor: Colors.deepOrange,
    //   //   ),
    //   //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   //     type: BottomNavigationBarType.fixed,
    //   //     selectedItemColor: Colors.deepOrange,
    //   //     unselectedItemColor: Colors.grey,
    //   //     elevation: 20.0,
    //   //     backgroundColor: HexColor('333739'),
    //   //   ),
    //   //   textTheme: TextTheme(
    //   //     bodyText1: TextStyle(
    //   //       fontSize: 18.0,
    //   //       fontWeight: FontWeight.w600,
    //   //       color: Colors.white,
    //   //     ),
    //   //   ),
    //   // ),
    //   // themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
    //   home: startWidget,
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSports(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            // themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
