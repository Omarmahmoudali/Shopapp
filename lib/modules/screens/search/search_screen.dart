import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/screens/search/cubit/cubit.dart';
import 'package:shopapp/modules/screens/search/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';

import '../../../layout/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        prefixIcon: Icons.search,
                        labelText: 'Search',
                        onFieldSubmitted: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        }
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if(state is SearchSuccessState)
                        Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index) =>buildListItem(SearchCubit.get(context).model!.data.data[index],context, isOldPrice: false),
                          separatorBuilder: (context,index) => myDivider(),
                          itemCount: SearchCubit.get(context).model!.data.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
        },
      ),
    );
  }

}
