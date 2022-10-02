
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/appstates.dart';
import 'package:news_app/shared/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) {
    return BlocProvider.of(context);
  }
  bool isDark=false;
  void changeMode({ bool? fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark',value: isDark).then((value) {
    emit(AppChangeModeState());
    },);
    }
    
  }
}