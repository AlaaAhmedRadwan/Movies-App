
 import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';

import '../../model/OnboardingModel.dart';

abstract final class Appconstants {
 static List<Onboardingmodel> OnboardingList =[
  Onboardingmodel(image: Assetsmanager.Onboarding1, title: Stringsmanager.title_onboarding1,
  desc: Stringsmanager.desc_onboarding1),
   Onboardingmodel(image: Assetsmanager.Onboarding2, title: Stringsmanager.title_onboarding2,
       desc: Stringsmanager.desc_onboarding2),
   Onboardingmodel(image: Assetsmanager.Onboarding3, title: Stringsmanager.title_onboarding3,
       desc: Stringsmanager.desc_onboarding3),
   Onboardingmodel(image: Assetsmanager.Onboarding4, title: Stringsmanager.title_onboarding4,
       desc: Stringsmanager.desc_onboarding4),
   Onboardingmodel(image: Assetsmanager.Onboarding5, title: Stringsmanager.title_onboarding5,
       desc: Stringsmanager.desc_onboarding5),
   Onboardingmodel(image: Assetsmanager.Onboarding6, title: Stringsmanager.title_onboarding6,),
 ];

}