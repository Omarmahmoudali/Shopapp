import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/profile_model.dart';
import 'package:shopapp/modules/screens/categories/categories_screen.dart';
import 'package:shopapp/modules/screens/favorites/favorites_screen.dart';
import 'package:shopapp/modules/screens/products/products_screen.dart';
import 'package:shopapp/modules/screens/settings/settings_screen.dart';
import 'package:shopapp/modules/screens/team_name.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../models/change_favorites_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
    const TeamName(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<dynamic, dynamic> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      /*printFullText(homeModel!.data!.banners[0].image);
      print(homeModel!.status);*/

      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites( productId)
  {
    favorites[productId]= !favorites[productId];
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id':productId
      },
      token: token,
    ).then((value)
    {
      changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(changeFavoritesModel!.status==false)
      {
        favorites[productId]= !favorites[productId];
      }else
        {
          getFavorites();
        }
      
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error)
    {
      favorites[productId]= !favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopProfileModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopProfileModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData(
  {
  required String name,
  required String email,
  required String phone,
}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: token,
    ).then((value) {
      userModel = ShopProfileModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }




}
