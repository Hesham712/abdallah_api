import 'package:abdallah_api/layout/shop_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(
                        '${ShopCubit.get(context).categoriesModel!.data!.data[index].image}'),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      '${ShopCubit.get(context).categoriesModel!.data!.data[index].name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                  ),
                ],
              ),
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
          );
        });
  }
}
