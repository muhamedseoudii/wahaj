import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:mo_wahaj_top/features/auth/presentation/widget/bottom_sheet/forgot_password_bottom_sheet.dart';
import 'package:mo_wahaj_top/features/auth/presentation/widget/title_text_field.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/widget/snack_bar/note_message.dart';
import '../widget/dialog/signup_dialog.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/12/2024.
 */

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late List<TextEditingController> controllers;
  late List<GlobalKey<FormState>> formKeys;

  @override
  void initState() {
    controllers = List.generate(2, (index) => TextEditingController());
    formKeys = List.generate(2, (index) => GlobalKey<FormState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextField(
                formKey: formKeys[0],
                controller: controllers[0],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return "error";
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                title: "userNameOrEmailAddress".tr(),
                hint: "userNameOrEmailAddress".tr()),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            TitleTextField(
              formKey: formKeys[1],
              controller: controllers[1],
              title: "password".tr(),
              hint: "password".tr(),
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "error";
                }
                return null;
              },
              isPasswordField: true,
            ),
            SizedBox(
              height: AppHeightSize.h1point8,
            ),

            SizedBox(
              height: AppHeightSize.h1point8,
            ),
            InkWell(
              onTap: () {
                showForgotPasswordBottomSheet(
                  context: context,
                );
              },
              child: AppText(
                text: "forgotPassword".tr(),
                fontSize: AppFontSize.sp15,
                textDecoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == CubitStatus.error) {
                  NoteMessage.showErrorSnackBar(
                      context: context, text: state.model.error??"");
                }
                if (state.status == CubitStatus.success) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.main, (route) => false);
                }
              },
              builder: (context, state) {
                if (state.status == CubitStatus.loading) {
                  return Center(
                    child: AppCircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                    onPressed: () {
                      if (isValidInput() == true) {
                        context.read<LoginCubit>().login(body: {
                          "email": controllers[0].text,
                          "password": controllers[1].text
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.purple,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthSize.w3point8,
                            vertical: AppHeightSize.h2),
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                        AppText(
                          text: "login".tr(),
                          fontSize: AppFontSize.sp15,
                          fontColor: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                      ],
                    ));
              },
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showSignUpDialog(context: context);
                },
                child: AppText(
                  text: "donotHaveAccount".tr(),
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.sp15,
                  fontColor: AppColor.grey,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
          ],
        ),
      ),
    );
  }

  bool isValidInput() {
    bool isOk = true;
    for (GlobalKey<FormState> element in formKeys) {
      isOk &= element.currentState?.validate() ?? false;
    }
    return isOk;
  }

  @override
  void dispose() {
    for (TextEditingController element in controllers) {
      element.dispose();
    }
    super.dispose();
  }
}
