
import 'package:shopapp/models/profile_model.dart';
import 'package:shopapp/models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState   extends ShopStates{}

class ShopLoadingHomeDataState   extends ShopStates{}

class ShopSuccessHomeDataState    extends ShopStates{}

class ShopErrorHomeDataState    extends ShopStates{}

class ShopSuccessCategoriesState    extends ShopStates{}

class ShopErrorCategoriesState    extends ShopStates{}

class ShopSuccessChangeFavoritesState    extends ShopStates{}

class ShopErrorChangeFavoritesState    extends ShopStates{}

class ShopLoadingGetFavoritesState    extends ShopStates{}

class ShopSuccessGetFavoritesState    extends ShopStates{}

class ShopErrorGetFavoritesState    extends ShopStates{}

class ShopLoadingUserDataState    extends ShopStates{}

class ShopSuccessUserDataState    extends ShopStates
{
  final ShopProfileModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState    extends ShopStates{}

class ShopLoadingUpdateUserState    extends ShopStates{}

class ShopSuccessUpdateUserState    extends ShopStates
{
  final ShopProfileModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState    extends ShopStates{}
