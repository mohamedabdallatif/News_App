import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/states.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';

import 'package:news_app/shared/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialState());
  static NewsCubit get(context) {
    return BlocProvider.of(context);
  }

  List screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
  ];
  void newsChangeNavBar(value) {
    currentIndex = value;
    
    /* if(currentIndex==1){
      getSports();
    }
    if(currentIndex==2){
      getScience();
    } */
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
   emit(NewsBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      quary: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '8311c395093946aabe6d8914eca62be4'
      },
    ).then((value) {
      business = value.data['articles'];
      //print(business[0]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((err) {
      //print('An error $err');
      emit(NewsGetBusinessErrorState(err));
    });
  }
  List<dynamic> sports=[];
  void getSports(){
    emit(NewsSportsLoadingState());
   DioHelper.getData(url:'v2/top-headlines' , 
    quary:{
        'country': 'eg',
        'category': 'sports',
        'apiKey': '8311c395093946aabe6d8914eca62be4'
      }
    ).then((value) {
      sports=value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((err){
      emit(NewsGetSportsErrorState(err));
    });
  }

  List<dynamic> science=[];
  void getScience(){
    emit(NewsScienceLoadingState());
   DioHelper.getData(url:'v2/top-headlines' , 
    quary:{
        'country': 'eg',
        'category': 'science',
        'apiKey': '8311c395093946aabe6d8914eca62be4'
      }
    ).then((value) {
      science=value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((err){
      emit(NewsGetScienceErrorState(err));
    });
  }

  List<dynamic> search=[];
  void getSearch(String value){
    emit(NewsSearchLoadingState());
    search=[];
   DioHelper.getData(url:'v2/everything' , 
    quary:{
        'q':value,
        'apiKey': '8311c395093946aabe6d8914eca62be4'
      }
    ).then((value) {
      search=value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((err){
      emit(NewsGetSearchErrorState(err));
    });
  }
}
