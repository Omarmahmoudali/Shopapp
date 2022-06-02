import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: model.data != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name Must Not Be empty';
                        }
                        return null;
                      },
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Must Not Be empty';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Must Not Be empty';
                        }
                        return null;
                      },
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      onPressed: () {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: 'Update',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      onPressed: () {
                        signOut(context);
                      },
                      text: 'LOG OUT',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),



                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
