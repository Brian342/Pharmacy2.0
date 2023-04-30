import 'package:brianpharmacy/constraints.dart';
import 'package:brianpharmacy/screens/dashboard/components/doctors_list.dart';
import 'package:brianpharmacy/screens/dashboard/components/druglist.dart';
import 'package:brianpharmacy/screens/dashboard/components/header_with_search_bar.dart';
import 'package:brianpharmacy/screens/dashboard/components/recomended_categories.dart';
import 'package:brianpharmacy/screens/dashboard/components/title_with_more_btn.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // This will provide us the total height and width of our screen
    Size size = MediaQuery.of(context).size;
    // this enables scrolling
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          // TitleWithBtn(
          //   title: "Categories",
          //   press: () {},
          // ),
          const RecomendedCategories(),
          TitleWithBtn(
              title: "Doctors",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const DrugList(),
                    ));
              }),
          const DoctorsList(),
          const SizedBox(
            height: kDefaultPadding,
          )
        ],
      ),
    );
  }
}
