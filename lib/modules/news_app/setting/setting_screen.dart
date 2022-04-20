import 'package:abdallah_api/layout/shop_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/shop_app/cubit/states.dart';
import 'package:abdallah_api/shared/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return Center(
          child: TextButton(
            onPressed: () {
              signOut(context);
            },
            child: Text('LOGOUT'),
          ),
        );
      },
    );
  }
}
