import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/splash_get_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  SplashGetController getController = Get.put(SplashGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          /*Container(
            height: 25.h,
            color: AppColors.primary,
          ),*/
          Expanded(
            child: FadeTransition(
              opacity: getController.animationController,
              child: Center(
                child: SizedBox(
                  width: 60.w,
                  child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                          'assets/images/Picsart_22-09-12_23-22-16-855-e1663734817338.png')),
                ),
              ),
            ),
          ),
          /*Container(
            height: 25.h,
            width: 100.w,
            color: AppColors.primary,
          ),*/
        ],
      ),
    );
  }
}
