import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }



  bool isDark = false;

  void changeAppMode({bool?fromShared}){
    if(fromShared != null)
    {
      isDark=fromShared;
      emit(AppChangeModeState());

    }
     else
      {
        isDark=!isDark;
        CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
        {
          emit(AppChangeModeState());
        }
        );
      }

  }
}
