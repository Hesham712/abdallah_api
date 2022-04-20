import 'package:abdallah_api/layout/shop_app/cubit/states.dart';
import 'package:abdallah_api/models/shop_app/categories_model.dart';
import 'package:abdallah_api/models/shop_app/home_model.dart';
import 'package:abdallah_api/modules/news_app/setting/setting_screen.dart';
import 'package:abdallah_api/modules/shop_app/cateogries/categories_screen.dart';
import 'package:abdallah_api/modules/shop_app/favorites/favorites_screen.dart';
import 'package:abdallah_api/modules/shop_app/products/products_screen.dart';
import 'package:abdallah_api/shared/components/constant.dart';
import 'package:abdallah_api/shared/network/end_points.dart';
import 'package:abdallah_api/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.status);
      // print(categoriesModel!.data?.currentPage);
      // print(categoriesModel!.data?.data[0].name);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }
}
