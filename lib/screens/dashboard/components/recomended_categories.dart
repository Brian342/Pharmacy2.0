import 'package:brianpharmacy/constraints.dart';
import 'package:brianpharmacy/screens/admin/adminPages/geo_location.dart';
import 'package:brianpharmacy/screens/dashboard/components/geolocation/googleMaps.dart';
import 'package:flutter/material.dart';

class RecomendedCategories extends StatelessWidget {
  const RecomendedCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const GoogleMaps()));
              },
              child: const Text("Location")),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (BuildContext context) => MapView(),
          //           ));
          //     },
              // child: const Text("Pick location")),
              //  ElevatedButton(
              // onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) => MapView(),
              //       ));
              // },
              // child: const Text("Admin Map view")),
          // RecomendedDrugs(
          //     image: "assets/images/pills2.png", title: "Pills", press: () {}),
          // RecomendedDrugs(
          //   image: "assets/images/drops.png",
          //   title: "Drops",
          //   press: () {
          //     const geolocationpage();
          //   },
          // ),
          // RecomendedDrugs(
          //   image: "assets/images/inhalers.jpg",
          //   title: "Inhalers",
          //   press: () {
          //     const geolocationpage();
          //   },
          // ),
          // RecomendedDrugs(
          //   image: "assets/images/liquid.png",
          //   title: "Liquid",
          //   press: () {
          //     const geolocationpage();
          //   },
          // ),
          // RecomendedDrugs(
          //   image: "assets/images/injection.jpg",
          //   title: "Injection",
          //   press: () {
          //     const geolocationpage();
          //   },
          // ),
          // RecomendedDrugs(
          //   image: "assets/images/tropical.png",
          //   title: "Tropical",
          //   press: () {
          //     const geolocationpage();
          //   },
          // ),
        ],
      ),
    );
  }
}

class RecomendedDrugs extends StatelessWidget {
  const RecomendedDrugs({
    super.key,
    required this.image,
    required this.title,
    required this.press,
  });

  final String image, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 5,
        bottom: kDefaultPadding / 4,
      ),
      width: size.width * 0.7,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            child: Image.asset(image),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 1),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23)),
                ],
              ),
              child: Row(children: <Widget>[
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
