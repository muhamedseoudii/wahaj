import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/core/widget/text_form_field/outline_text_form_field.dart';
import 'package:mo_wahaj_top/features/account/cubit/add_business_cubit/add_business_cubit.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../../../auth/presentation/widget/phone_number_widget.dart';

class AddBusinessForm extends StatefulWidget {
  const AddBusinessForm({super.key});

  @override
  State<AddBusinessForm> createState() => _AddBusinessFormState();
}

class _AddBusinessFormState extends State<AddBusinessForm> {
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
      color: Colors.white.withOpacity(0.1),
      // margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
      // padding: EdgeInsets.symmetric(
      //     horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      // decoration: BoxDecoration(
      //     color: Colors.white54,
      //     borderRadius: BorderRadius.circular(10),
      //     boxShadow: [
      //       BoxShadow(
      //           color: AppColor.lightGrey, blurRadius: 25, offset: Offset(1, 9))
      //     ]),
      child: Column(
        children: [
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            textAlign: TextAlign.center,
            text: "toAddYourBusinessFillOutTheFollowingForm".tr(),
            fontWeight: FontWeight.w500,
            fontColor: AppColor.navy,
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
              hint: "workTopic".tr(),
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
              hint: "workDescription".tr(),
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
          BlocConsumer<AddBusinessCubit, AddBusinessState>(
            listener: (context, state) {
              if (state.status == CubitStatus.success) {
                NoteMessage.showSuccessSnackBar(
                    context: context, text: "sentSuccessfully".tr());
              }
              if (state.status == CubitStatus.error) {
                NoteMessage.showErrorSnackBar(
                    context: context, text: state.model.error ?? "");
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
                      return;
                    }
                    context.read<AddBusinessCubit>().addBusiness(body: {
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
    return isOk;
  }
}
