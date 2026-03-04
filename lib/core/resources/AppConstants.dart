

import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/model/BoosterModel.dart';

import '../../model/OnboardingModel.dart';

abstract final class Appconstants {
 static List<Onboardingmodel> OnboardingList =[
  Onboardingmodel(image: Assetsmanager.Onboarding1, title: StringsManager.titleOnboarding1,
  desc: StringsManager.descOnboarding1),
   Onboardingmodel(image: Assetsmanager.Onboarding2, title: StringsManager.titleOnboarding2,
       desc: StringsManager.descOnboarding2),
   Onboardingmodel(image: Assetsmanager.Onboarding3, title: StringsManager.titleOnboarding2,
       desc: StringsManager.descOnboarding3),
   Onboardingmodel(image: Assetsmanager.Onboarding4, title: StringsManager.titleOnboarding3,
       desc: StringsManager.descOnboarding4),
   Onboardingmodel(image: Assetsmanager.Onboarding5, title: StringsManager.titleOnboarding4,
       desc: StringsManager.descOnboarding5),
   Onboardingmodel(image: Assetsmanager.Onboarding6, title: StringsManager.titleOnboarding5,),
 ];
 static List<Boostermodel> moviesList =[
   Boostermodel(imagePath: Assetsmanager.movies1, rating: 7.7),
   Boostermodel(imagePath: Assetsmanager.movies2, rating: 7.7),
   Boostermodel(imagePath: Assetsmanager.movies3, rating: 7.7),
   Boostermodel(imagePath: Assetsmanager.movies4, rating: 7.7),
   Boostermodel(imagePath: Assetsmanager.movies5, rating: 7.7),
 ];
 static List<String> genresList = [
   "Action",
   "Comedy",
   "Drama",
   "Horror",
   "Romance",
 ];

}