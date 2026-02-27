
 import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';

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

}