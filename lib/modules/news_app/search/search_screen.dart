import 'package:abdallah_api/layout/news_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/news_app/cubit/states.dart';
import 'package:abdallah_api/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).Search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (String value){
                    if(value.isEmpty){
                      return 'search must not empty';
                    }
                    return null;
                  },
                  label: 'search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                  child: articleBuilder(list, context),
              ),
            ],
          ),
        );
      },
    );
  }
}
