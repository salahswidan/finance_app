import 'package:finance_app/color/colors.dart';
import 'package:finance_app/page/home_page.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  List<PageItem> item = [
    PageItem(
        title: 'Title 1',
        image: 'assets/image/finance1.png',
        subTitle: 'subTitle 1'),
    PageItem(
        title: 'Title 2',
        image: 'assets/image/finance2.png',
        subTitle: 'subTitle 2'),
    PageItem(
        title: 'Title 3',
        image: 'assets/image/finance3.png',
        subTitle: 'subTitle 3'),
  ];
  int currentIndex = 0;
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false);
            },
            child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: KPrimaryGreen,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                    child: Text(
                  "skip",
                  style: TextStyle(color: Colors.white),
                ))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                  if (value + 1 == item.length) {
                    setState(() {
                      isLastPage = true;
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return item[index];
                },
                itemCount: item.length,
                controller: pageController,
              ),
            ),
            Row(
              children: [
                Text("${currentIndex + 1}/${item.length}"),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KPrimaryGreen,
                      foregroundColor: KwhiteColor,
                    ),
                    onPressed: () {
                      isLastPage
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false)
                          : pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut);
                    },
                    child: Text(isLastPage ? "Get Started" : 'Next'))
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final String title;
  final String image;
  final String subTitle;
  const PageItem({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold, color: KPrimaryGreen),
        ),
        Text(subTitle),
      ],
    );
  }
}
