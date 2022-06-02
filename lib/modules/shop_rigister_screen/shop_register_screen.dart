import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/modules/shop_rigister_screen/register_cubit/cubit.dart';
import 'package:shopapp/modules/shop_rigister_screen/register_cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

import '../../shared/components/constants.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status==true){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
              {
                token=state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout(),);
              });
            }else{
              print(state.loginModel.message);
              showToast(text: state.loginModel.message, state: ToastStates.error);
            }
          }
        },
        builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Let\'s Get Started!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Create an account to E Commerce to get all feature',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          labelText: 'NAME',
                          prefixIcon: Icons.person
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Email';
                          }
                        },
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Phone';
                          }
                        },
                        labelText: 'Phone',
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Password';
                          }
                        },
                        suffixIcon: ShopRegisterCubit.get(context).suffix,
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        suffixPressed: ()
                        {
                          ShopRegisterCubit.get(context).changePasswordVisibility();
                        },
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          }
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: Colors.blue,
                        ),
                        width: 175.0,
                        child: ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=> defaultButton(
                            onPressed: () {
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Create',
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopLoginScreen()));
                              },
                              child: const Text(
                                'Login here',
                              ))
                        ],
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
