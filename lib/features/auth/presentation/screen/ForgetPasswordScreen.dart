import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';

import '../../../../core/resources/AssetsManager.dart';
import '../../../../core/resources/StringsManager.dart';
import '../../../../core/reusable/CustomButton.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/CustomAuthTextField.dart';

class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
        appBar: AppBar(centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(StringsManager.forgetPass.tr(),
          style: TextStyle(
            color: ColorsManager.onPrimaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 16
          ),),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC107)),
              onPressed: () => context.pop(),
        )),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                      Image.asset(Assetsmanager.forgotpass),
                  SizedBox(height: 16,),
                        CustomAuthTextField(
                          hintText:StringsManager.email.tr(),
                          prefixIcon: Icons.email,
                          controller: emailController,
                          validator: Validators.email,
                        ),
                    SizedBox(height: 16,),
                    Container(
                        width: double.infinity,
                        child: CustomButton(title: StringsManager.verifyemail.tr(),
                            onClick: (){}
                        ))])))));}}