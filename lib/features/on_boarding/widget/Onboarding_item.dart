import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/AppConstants.dart';
import '../../../core/resources/ColorsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable/CustomButton.dart';
import '../../../core/routing/app_router.dart';
import '../../../model/OnboardingModel.dart';

class OnboardingItem extends StatefulWidget {
  Onboardingmodel model;
  final int index;
  final int pageIndex;
  final PageController controller;

   OnboardingItem({required this.model,required this.controller,
     required this.index,
     required this.pageIndex,

   });

  @override
  State<OnboardingItem> createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    bool isFirst = widget.pageIndex == 0;
    bool isSecond = widget.pageIndex == 1;
    bool isLast =
        widget.pageIndex == Appconstants.OnboardingList.length - 1;

    return
        Stack(
            children: [
              SizedBox.expand(
                  child: Image.asset(widget.model.image, fit: BoxFit.fill,)),
    Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                )
                ,decoration: BoxDecoration(
             color: isFirst
              ? Colors.transparent
               : ColorsManager.PrimaryColor,
               borderRadius: BorderRadius.only(topRight: Radius.circular(40.r),
               topLeft: Radius.circular(40.r)
               ),),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                         mainAxisSize: MainAxisSize.min,
                           children: [
                             Text(widget.model.title.tr(),
                                textAlign:TextAlign.center,
                                style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsManager.SecondaryColor,
                                ),),
                             SizedBox(height: 16.h,),
                             if (widget.model.desc.isNotEmpty)
                               Text(widget.model.desc.tr(),
                          textAlign:TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.SecondaryColor.withValues(
                              alpha: 0.6,
                            ),),),
                             SizedBox(height: 24.h,),
                             if (isFirst) ...[
                          CustomButton(
                            title: StringsManager.exploreNow.tr(),
                            onClick: () {
                              widget.controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,);},
                          ),]
                             else if (isSecond) ...[
                          CustomButton(
                            title: StringsManager.next.tr(),
                            onClick: () {
                              widget.controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,);},
                          ),]
                             else ...[
                                CustomButton(
                                  title: isLast
                                      ? StringsManager.finish.tr()
                                      : StringsManager.next.tr(),
                                  onClick: () {
                                    if (isLast) {
                                      context.go(AppRouter.login);
                                    } else {
                                      widget.controller.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,);}
                                  },
                                ),
                            SizedBox(height: 12.h),
                            CustomButton(
                              title: StringsManager.back.tr(),
                              backgroundColor: ColorsManager.PrimaryColor,
                              textColor: ColorsManager.onPrimaryColor,
                              onClick: () {
                                widget.controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,);},
                            ),
                          ]
                           ],),
                       )
              ]),]);
  }
}
