// ignore_for_file: file_names, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final log = box.read('login') ?? false;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Get.off(
        () => log ? HomeScreen() : LoginView(),
        transition: Transition.fadeIn,
        curve: Curves.bounceInOut,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 120,
              left: -40,
              child: Center(
                child: Lottie.asset(
                  KPICSPLASH,
                  animate: true,
                  height: 460,
                  fit: BoxFit.cover,
                ),
              )),
          Opacity(
            opacity: .3,
            child: Image.asset(
              'assets/images/login2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: Get.size.width * .30,
            top: Get.size.height * .68,
            child: Wrap(
              children: const [
                My_Text(data: 'ife', color: scColor, size: 20),
                My_Text(data: 'L ', color: reColor, size: 20),
                My_Text(data: ' is ', color: prColor, size: 26),
                My_Text(data: ' ime', color: pr2Color, size: 20),
                My_Text(data: 'T ', color: biColor, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
















/* class LoginView extends GetView<LoginController>  {

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

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
                    alignment: FractionalOffset(controller.animation.value, 0),
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

  Widget FormLogin() {
    return Center(
      child: Form(
        key: controller.formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.isLoader
                ? const SizedBox()
                : const Center(
                    heightFactor: 10,
                    child: CircularProgressIndicator(),
                  ),
            GFTextFieldRounded(
              labal: mytext(data: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'برجاء ادخال الايميل';
                }
                return null;
              },
              controller: controller.emailcontroller,
              editingbordercolor: GFColors.WARNING,
              idlebordercolor: GFColors.WHITE,
              borderwidth: 2,
              cornerradius: 15,
              hintText: 'ادخل الايميل',
            ),
            GFTextFieldRounded(
              labal: mytext(data: 'PassWord'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'برجاء ادخال الرقم السري ';
                }
                return null;
              },
              controller: controller.passwordcontroller,
              editingbordercolor: GFColors.PRIMARY,
              idlebordercolor: GFColors.WHITE,
              borderwidth: 2,
              cornerradius: 15,
              hintText: 'ادخل الرقم السري',
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Login'.toUpperCase()),
                  onPressed: () {
                    if (controller.formkey.currentState!.validate()) {
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
}
 */