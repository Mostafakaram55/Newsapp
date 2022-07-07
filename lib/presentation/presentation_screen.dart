
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ymcs/modules/search/search_screen.dart';
import 'package:ymcs/shared/cubit/cubit.dart';
import 'package:ymcs/shared/cubit/states.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:ymcs/shared/network/linked.dart';
class Bresentation extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,states){},
        builder:(context,states)
        {
          var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 100,
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children:
                      [
                        NeumorphicText(
                            'News',
                          style: NeumorphicStyle(
                            depth: 5,
                            color: Colors.white,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions:
              [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context,Search());
                  },
                  icon: Icon(
                      Icons.search,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: ()
                  {
                    NewsCubit.get(context).changeMode();
                  },
                  icon: Icon(
                      Icons.brightness_4_outlined
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.bottom,
              currentIndex: cubit.currentIndex,
              onTap:(index)
              {
                cubit.Current(index);
              },
            ),
            body:cubit.Screen[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
