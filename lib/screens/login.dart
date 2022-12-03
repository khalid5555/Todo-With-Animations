// ignore_for_file: file_names, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/text_field/gf_text_field_rounded.dart';
import '/ui/constant/themes.dart';

import '../ui/constant/component.dart';
import 'home.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isLoader = true;
  var log = false;

  @override
  void dispose() {
    animationController.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();
    super.initState();
  }

  FormLogin() {
    return Center(
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoader
                ? const SizedBox()
                : const Center(
                    heightFactor: 10,
                    child: CircularProgressIndicator(),
                  ),
            GFTextFieldRounded(
              enabled: true,
              labal: const My_Text(data: 'البريد الالكتروني'),
              validator: (value) {
                // RegExp(r'[A-Z]'
                if (value!.isEmpty || !value.contains('@')) {
                  return 'برجاء ادخال البريد بشكل صحيح';
                }
                return null;
              },
              controller: emailcontroller,
              editingbordercolor: GFColors.WARNING,
              idlebordercolor: GFColors.TRANSPARENT,
              borderwidth: 2,
              cornerradius: 15,
              hintText: 'ادخل الايميل',
            ),
            GFTextFieldRounded(
              labal: const My_Text(data: 'الرقم السري'),
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'برجاء ادخال الرقم السري اكبر من 6 ارقام';
                }
                return null;
              },
              controller: passwordcontroller,
              editingbordercolor: GFColors.PRIMARY,
              idlebordercolor: GFColors.TRANSPARENT,
              borderwidth: 2,
              cornerradius: 15,
              hintText: 'ادخل الرقم السري',
            ),
            SizedBox(
              width: double.infinity - 50,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(prColor)),
                  child: My_Text(
                    data: 'تسجيل الدخول'.toUpperCase(),
                    size: 20,
                    color: pr2Color,
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      // log = true;
                      box.write('login', true);
                      Get.off(HomeScreen());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Opacity(
                  opacity: .5,
                  child: Image.asset(
                    'assets/images/login1.jpg',
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(animation.value, 0),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FormLogin(),
              const SizedBox(
                height: 120,
              )
            ],
          )
        ],
      ),
    );
  }
}
