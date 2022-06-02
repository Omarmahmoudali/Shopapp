import 'package:flutter/cupertino.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value)
              {
                navigateAndFinish(context, ShopLoginScreen());
              });
}


void printFullText(text)
{
final pattern = RegExp('.{1,800}');
pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}

String ? token ='';
