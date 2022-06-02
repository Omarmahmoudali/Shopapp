import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/shop_rigister_screen/shop_register_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state)
         {
           if(state is ShopLoginSuccessState){
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
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          onFieldSubmitted: (value)
                          {
                             if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                          }
                          ,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                           {
                             ShopLoginCubit.get(context).changePasswordVisibility();
                           },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\`t have an account?'),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'Register',
                            ),
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
