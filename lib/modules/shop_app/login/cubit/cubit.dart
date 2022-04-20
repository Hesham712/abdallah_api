import 'package:abdallah_api/models/shop_app/login_model.dart';
import 'package:abdallah_api/modules/shop_app/login/cubit/states.dart';
import 'package:abdallah_api/shared/network/end_points.dart';
import 'package:abdallah_api/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginLoadingState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = false;
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibality(){
    isPassword = !isPassword;
    emit(ShopLoginPasswordVisibilityState());
  }
}
