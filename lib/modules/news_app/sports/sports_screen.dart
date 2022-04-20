import 'package:abdallah_api/layout/news_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/news_app/cubit/states.dart';
import 'package:abdallah_api/shared/components/components.dart';
import 'package:flutter/material.dart';
// import 'package:conditional_builder/conditional_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context,state){
        var list = NewsCubit.get(context).Sports;
        return articleBuilder(list, context);
      },
      listener: (context,state){},
    );
  }
}
