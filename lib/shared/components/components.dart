import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/shared/styles/colors.dart';


Widget defaultButton({
  bool isUpperCase = true,
  double? width = double.infinity,
  Color? color = Colors.blue,
  double radius = 10.0,
  required Function onPressed,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function onPressed,
  required String text,
})=>TextButton(
  onPressed: (){
  onPressed();
},
  child: Text(text),);

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType type,
  Function(String val)?onFieldSubmitted,
  Function(String val)? onChanged,
  Function()? onTap,
  required String? Function(String? value)? validator,
   String? labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted ,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
        ),
        labelText: labelText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffixIcon,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0)),
      ),
    );



class CustomText extends StatelessWidget {
  final String text;
  final Color color;

  final double fontsize;

  const CustomText({
    required this.text,
    required this.color,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
      ),
    );
  }
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );


void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context , widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false);




void showToast(
  {
    required String text,
    required ToastStates state ,
  }
  )=> Fluttertoast.showToast(
                msg: text,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: chooseToastColor(state),
                textColor: Colors.white,
                fontSize: 16.0,
                  );


enum ToastStates {success, error, warning}


Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color=Colors.red;
      break; 
    case ToastStates.warning:
      color=Colors.amber;
      break;    
  }
  return color;
}


Widget buildListItem(model,context,{bool isOldPrice = true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                  '${model.image}'),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: const Text(
                  'Discount',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              )
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.toString()}',
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.grey[350],
                      child: Icon(
                          ShopCubit.get(context).favorites[model.id] ? Icons.shopping_cart_rounded :Icons.shopping_cart_outlined,
                          size: 20.0,
                          color: ShopCubit.get(context).favorites[model.id] ?Colors.red : Colors.black
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

