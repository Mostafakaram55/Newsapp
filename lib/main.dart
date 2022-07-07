import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ymcs/modules/splash/splash.dart';
import 'package:ymcs/presentation/presentation_screen.dart';
import 'package:ymcs/shared/cubit/cubit.dart';
import 'package:ymcs/shared/cubit/states.dart';
import 'package:ymcs/shared/network/remot/dio_heiper.dart';
void main() {
  DioHelper.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch:Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                backgroundColor: Colors.grey[300],
                appBarTheme:AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle:SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    iconTheme:IconThemeData(
                        color: Colors.black
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  elevation: 20,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black
                    )
                )
            ),
            darkTheme: ThemeData(
                backgroundColor:HexColor('#00002e'),
                appBarTheme:AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle:SystemUiOverlayStyle(
                      statusBarColor: HexColor('#242726') ,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor:HexColor('#242726') ,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    iconTheme:IconThemeData(
                        color: Colors.white
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blueAccent,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('#242726'),
                  elevation: 20
                ),
                scaffoldBackgroundColor: HexColor('#242726'),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white
                    ),
                ),
            ),
            themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:Splash() ,
          );
        },
      ),
    );
  }
}


