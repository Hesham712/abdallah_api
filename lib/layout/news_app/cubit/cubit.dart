import 'package:abdallah_api/layout/news_app/cubit/states.dart';
import 'package:abdallah_api/modules/news_app/business/business_screen.dart';
import 'package:abdallah_api/modules/news_app/science/science_screen.dart';
import 'package:abdallah_api/modules/news_app/setting/setting_screen.dart';
import 'package:abdallah_api/modules/news_app/sports/sports_screen.dart';
import 'package:abdallah_api/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// newsapi.org/v2/everything?
// q=tesla&apiKey=c8d3ab44b681409c8f2baabda5c05c6c
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'c8d3ab44b681409c8f2baabda5c05c6c',
      },
    ).then((value){
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> Science = [];

  void getScience(){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'c8d3ab44b681409c8f2baabda5c05c6c',
      },
    ).then((value){
      Science = value.data['articles'];
      print(Science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }


  List<dynamic> Sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sport',
        'apiKey':'c8d3ab44b681409c8f2baabda5c05c6c',
      },
    ).then((value){
      Sports = value.data['articles'];
      print(Sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  // bool isDark = false;
  // void changeAppMode(){
  //   isDark = !isDark;
  //   print(isDark);
  //   emit(AppChangeModeState());
  // }

  List<dynamic> Search = [];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'c8d3ab44b681409c8f2baabda5c05c6c',
      },
    ).then((value){
      Search = value.data['articles'];
      print(Search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

