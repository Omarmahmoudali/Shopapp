import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/screens/search/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: PRODUCT_SEARCH,
        token: token,
        data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
