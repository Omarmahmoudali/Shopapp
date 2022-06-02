import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/shared/components/components.dart';
import '../../../layout/cubit/states.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder:(context, state) {
        return  ConditionalBuilder(
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index) =>buildListItem(ShopCubit.get(context).favoritesModel!.data.data[index].product,context),
            separatorBuilder: (context,index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
          ),
          condition: state is! ShopLoadingGetFavoritesState ,
          fallback:(context)=>const Center(child: CircularProgressIndicator()),

        );
      },

    );
  }



}
