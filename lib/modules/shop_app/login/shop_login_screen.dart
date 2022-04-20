import 'dart:ui';

import 'package:abdallah_api/layout/shop_app/shop_layout.dart';
import 'package:abdallah_api/modules/shop_app/login/cubit/cubit.dart';
import 'package:abdallah_api/modules/shop_app/login/cubit/states.dart';
import 'package:abdallah_api/shared/components/components.dart';
import 'package:abdallah_api/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
                navigateAndFinish(context, ShopLayout());
              });
              ShowToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
            }else{
              print(state.loginModel.message);
              ShowToast(text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: null,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email address must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          onChanged: (value){
                              FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                          },
                          onFieldSubmitted: (value){
                            FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(ShopLoginCubit.get(context).isPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: (){
                                if(ShopLoginCubit.get(context).isPassword){
                                  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
                                }else{
                                  FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                                }
                                ShopLoginCubit.get(context).changePasswordVisibality();
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => TextButton(
                            onPressed: () {
                              FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              color: Colors.blue,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
