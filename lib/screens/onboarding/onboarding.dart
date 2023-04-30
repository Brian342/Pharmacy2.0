import 'package:brianpharmacy/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:brianpharmacy/screens/onboarding/OnboardModel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardModel> slides = [];
  int currentIndex = 0;
  bool isLastPage = false;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getSlides();
    controller.addListener(() {
      setState(() {
        currentIndex = controller.page!.round();
      });
    });
  }

  void jumpToPage(int page) {
    setState(() {
      currentIndex = page;
    });
    controller.animateToPage(page,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() => isLastPage = value == 1);
              },
              itemCount: slides.length,
              itemBuilder: (context, index) {
                //contents of the slider
                return Slider(
                    image: slides[index].getImage(),
                    title: slides[index].getTitle(),
                    description: slides[index].getDescription());
              },
            ),
          ),
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              color: const Color.fromARGB(0, 255, 255, 255),
              padding: const EdgeInsets.only(
                bottom: 2,
                right: 4,
                left: 4,
              ),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: (const Color.fromARGB(255, 151, 26, 22)),
                    minimumSize: const Size.fromHeight(50)),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () async {
                  // navigate directly to auth screen
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('testpage', true);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              color: Colors.transparent,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      'SKIP',
                      style: TextStyle(color: Color.fromARGB(255, 252, 17, 0)),
                    ),
                    onPressed: () => controller.jumpToPage(2),
                  ),
                  Center(
                      child: SmoothPageIndicator(
                    controller: controller,
                    count: 2,
                    effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700),
                    onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                  )),
                  TextButton(
                    child: const Text(
                      'NEXT',
                      style: TextStyle(color: Color.fromARGB(255, 252, 17, 0)),
                    ),
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                  ),
                ],
              ),
            ),
    );
  }
}

class Slider extends StatelessWidget {
  final String? image, title, description;

  //constructor
  Slider({this.image, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      //column containing image
      //title and dexcription
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              image.toString(),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 0.9, right: 0.9),
            child: Text(
              title.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 151, 22, 22),
              ),
            ),
          ),
          SizedBox(height: 2.5),
          Padding(
            padding: EdgeInsets.only(left: 6, right: 6),
            child: Text(
              description.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
