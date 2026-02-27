
import 'package:flutter/material.dart';

import '../../../core/resources/AppConstants.dart';
import '../widget/Onboarding_item.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller =PageController();
  int pageindex=0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: PageView.builder(
         onPageChanged: (index) {
           setState(() {
             pageindex = index;
           });
         },
         controller: controller,
         itemCount:Appconstants.OnboardingList.length ,
         itemBuilder: (context, index) {
           return OnboardingItem(

             pageIndex: pageindex,
             index: index,
               controller: controller,
               model:Appconstants.OnboardingList[index]
           );}
     )
   );
  }
}
