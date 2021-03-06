import 'package:abdallah_api/shared/components/components.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token',).then((value){
    if(value!){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token = '';