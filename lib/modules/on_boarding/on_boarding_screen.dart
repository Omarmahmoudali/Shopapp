import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/image/OnlineShop.png',
        title: 'Explore',
        body: 'Choose Whatever the Product you wish for with the easiest way possible using ShopMart'),
    BoardingModel(
        image: 'assets/image/Delivery.png',
        title: 'Shipping',
        body: 'Yor Order will be shipped to you as fast as possible by our carrier'),
    BoardingModel(
        image: 'assets/image/Payment.png',
        title: 'Make the Payment',
        body: 'Pay with the safest way possible either by cash or credit cards'),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(
      key: 'onBoarding', 
      value: true,
    ).then((value) 
    {
      if(value){
        navigateAndFinish(
          context,
          ShopLoginScreen(),
           );
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: submit,
             text: 'skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      spacing: 5,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                    submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
