import 'package:abdallah_api/layout/news_app/cubit/states.dart';
import 'package:abdallah_api/layout/todo_app/cubit/states.dart';
import 'package:abdallah_api/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else
      isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
      print(isDark);
      emit(AppChangeModeStates());
    });

  }
}

