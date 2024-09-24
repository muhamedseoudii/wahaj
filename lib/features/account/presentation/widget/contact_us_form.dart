import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/helper/validtor_helper.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/core/widget/text_form_field/outline_text_form_field.dart';
import 'package:mo_wahaj_top/features/account/cubit/submit_message_cubit/submit_message_cubit.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../../../auth/presentation/widget/phone_number_widget.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  List<TextEditingController> controllers = [];
  List<GlobalKey<FormState>> formKeys = [];
  String phoneNumber = '';
  GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    controllers = List.generate(4, (index) => TextEditingController());
    formKeys = List.generate(4, (index) => GlobalKey<FormState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: "feelFreeToReachOut".tr(),
            fontWeight: FontWeight.w500,
            fontColor: AppColor.purple,
            fontSize: AppFontSize.sp18,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "fullName".tr(),
              controller: controllers[0],
              formKey: formKeys[0],
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
              focusedBorderColor: AppColor.purple,
              enabledBorderColor: AppColor.grey1),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "email".tr(),
              controller: controllers[1],
              formKey: formKeys[1],
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }

                if ((value ?? "").isValidEmail() == false) {
                  return "pleaseEnterValidEmail".tr();
                }
                return null;
              },
              textInputType: TextInputType.emailAddress,
              focusedBorderColor: AppColor.purple,
              enabledBorderColor: AppColor.grey1),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          PhoneNumberWidget(
            formKey: phoneNumberFormKey,
            isOnlySA: false,
            onPhoneNumberChanged: (phone) {
              phoneNumber = phone;
            },
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "topic".tr(),
              controller: controllers[2],
              formKey: formKeys[2],
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
              focusedBorderColor: AppColor.purple,
              enabledBorderColor: AppColor.grey1),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "message".tr(),
              controller: controllers[3],
              formKey: formKeys[3],
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
              textAlignVertical: TextAlignVertical.top,
              edgeInsets: EdgeInsets.symmetric(
                  horizontal: AppWidthSize.w3point8,
                  vertical: AppHeightSize.h3),
              focusedBorderColor: AppColor.purple,
              enabledBorderColor: AppColor.grey1),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          BlocConsumer<SubmitMessageCubit, SubmitMessageState>(
            listener: (context, state) {
              if (state.status == CubitStatus.error) {
                NoteMessage.showErrorSnackBar(
                    context: context, text: state.model.error ?? "");
              }

              if (state.status == CubitStatus.success) {
                NoteMessage.showSuccessSnackBar(
                    context: context, text: "sentSuccessfully".tr());
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
                    if (isValidInput() == false) {
                      NoteMessage.showErrorSnackBar(
                          context: context, text: "pleaseEnterValidForm".tr());
                      return;
                    }
                    context.read<SubmitMessageCubit>().submitMessage(body: {
                      "full_name": controllers[0].text,
                      "email": controllers[1].text,
                      "phone_number": phoneNumber,
                      "topic": controllers[2].text,
                      "message": controllers[3].text,
                    });
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
                        text: "submit".tr(),
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (TextEditingController element in controllers) {
      element.dispose();
    }
    super.dispose();
  }

  bool isValidInput() {
    bool isOk = true;
    for (GlobalKey<FormState> element in formKeys) {
      isOk &= element.currentState?.validate() ?? false;
    }
    bool isPhoneNumberOk =
        (phoneNumberFormKey.currentState?.validate() ?? false);
    return isOk && isPhoneNumberOk;
  }
}
