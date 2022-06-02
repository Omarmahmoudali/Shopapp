import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/shared/styles/colors.dart';

import '../../../layout/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) => productsBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel,context),
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.8,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProducts(model.data!.products[index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProducts(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon:  CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.grey[350],
                          child: Icon(
                            ShopCubit.get(context).favorites[model.id] ? Icons.shopping_cart_rounded : Icons.shopping_cart_outlined,
                            size: 20.0,
                            color: ShopCubit.get(context).favorites[model.id] ?Colors.red : Colors.black
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(
              0.8,
            ),
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
