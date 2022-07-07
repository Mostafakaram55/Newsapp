import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ymcs/modules/business/business_screen.dart';
import 'package:ymcs/modules/science/sciencs_screen.dart';
import 'package:ymcs/modules/settings/setting.dart';
import 'package:ymcs/modules/sports/sports_screen.dart';
import 'package:ymcs/shared/cubit/states.dart';
import 'package:ymcs/shared/network/remot/dio_heiper.dart';
class NewsCubit extends Cubit <NewsStates>
{
  NewsCubit():super (NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottom=
  [
    BottomNavigationBarItem(
        icon:Icon(Icons.business_center),
        label: 'Business',
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.sports_kabaddi_outlined),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.science_rounded),
        label: 'Science'
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.settings),
        label: 'Settings'
    ),
  ];
  void Current(index){
    currentIndex=index;
    if(index==1)
      getSport();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<Widget> Screen=
  [
    Business(),
    Sports(),
    Science(),
    Setting()
  ];
  List<dynamic> business =[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
     DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'category':'business',
          'language':'ar',
          'apiKey':'5d81ac81725740ed806cd29fb33ca37b'
        }
    ).then((value) {
      business = value.data['articles'];//اسم الليست اي في الباك يند
      print(business);//كنت بجرب حاجه عادي
      emit(NewsGetBusinessSuccessState());
     }).catchError((e){
       print(e.toString());
       emit(NewsGetBusinessErrorState(e.toString()));
     });
  }

  List<dynamic> sport =[];
  void getSport(){
    emit(NewsGetSportsLoadingState());
    if(sport.length==0){//علشان يلووود مرة واحده بسسسس
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'category':'sports',
            'language':'ar',
            'apiKey':'5d81ac81725740ed806cd29fb33ca37b'
          }
      ).then((value) {
        sport = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((e){
        print(e.toString());
        emit(NewsGetSportsErrorState(e.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science =[];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){//علشان يلووود مرة واحده بسسسس بردك
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'category':'science',
            'language':'ar',
            'apiKey':'5d81ac81725740ed806cd29fb33ca37b',
          }
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((e){
        print(e.toString());
        emit(NewsGetScienceErrorState(e.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> Search =[];
  void getSearch(value){
    emit(NewsGetSearchLoadingState());

    Search =[];
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':'$value',
          'language':'ar',
          'apiKey':'5d81ac81725740ed806cd29fb33ca37b'
        }
    ).then((value) {
      Search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(NewsGetSearchErrorState(e.toString()));
    });
  }

  bool isDark=false;
  void changeMode(){
    isDark= !isDark;
    emit(NewsModeState());
  }
}