import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/shop_rigister_screen/register_cubit/states.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }
}
