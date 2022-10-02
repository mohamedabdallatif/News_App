import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/appcubit.dart';
import 'package:news_app/layout/appstates.dart';
import 'package:news_app/layout/cubit.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/local/cache_helper.dart';
import 'package:news_app/shared/remote/dio_helper.dart';
void main(List<String> args)async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
 bool? isDark=CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}
class MyApp extends StatelessWidget {
  final bool? isDark;
    const MyApp(this.isDark,{super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(BuildContext context) { return NewsCubit()..getBusiness()..getSports()..getScience();}),
        BlocProvider(create: (BuildContext context) { return AppCubit()..changeMode(fromShared: isDark); }),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme:const AppBarTheme(
              titleSpacing: 20.0,
              color: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                
              ),
              iconTheme:  IconThemeData(
              color: Colors.black
            )
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            textTheme: const TextTheme(
              bodyText1:TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600)
               )
            
          ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: HexColor('333739'),
          primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              color: HexColor('333739'),
              elevation: 0.0,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
                
              ),
              iconTheme:  const IconThemeData(
              color: Colors.white
            )
            ),
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: HexColor('333739')
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            textTheme: const TextTheme(
              bodyText1:TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)
               )
        ),
        themeMode:AppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const NewsLayout(),
        );
          },
      ),
    );
  }
}
