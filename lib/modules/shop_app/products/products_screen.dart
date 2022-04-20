import 'package:abdallah_api/layout/shop_app/cubit/cubit.dart';
import 'package:abdallah_api/layout/shop_app/cubit/states.dart';
import 'package:abdallah_api/models/shop_app/categories_model.dart';
import 'package:abdallah_api/models/shop_app/home_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              homeBuilder(cubit.homeModel, cubit.categoriesModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class homeBuilder extends StatelessWidget {
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  homeBuilder(this.homeModel, this.categoriesModel);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel?.data!.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 300.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 110,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                              '${categoriesModel!.data!.data[index].image}'),
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 110,
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            '${categoriesModel!.data!.data[index].name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 5,
                    ),
                    itemCount: categoriesModel!.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              homeModel!.data!.products.length,
              (index) => buildGridProduct(homeModel!.data!.products[index]),
            ),
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.58,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ],
      ),
    );
  }
}

class buildGridProduct extends StatelessWidget {
  ProductModel? productModel;

  buildGridProduct(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${productModel?.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (productModel?.discount != 0)
                Container(
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  color: Colors.deepOrange,
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productModel?.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel?.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (productModel?.discount != 0)
                      Text(
                        '${productModel?.old_price}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
