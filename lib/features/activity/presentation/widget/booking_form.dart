import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/helper/validtor_helper.dart';
import 'package:mo_wahaj_top/features/account/cubit/add_business_cubit/add_business_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_booking_cubit/add_booking_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_booking_cubit/add_booking_state.dart';
import 'package:mo_wahaj_top/features/auth/presentation/widget/phone_number_widget.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/resource/cubit_status.dart';
import '../../../../core/widget/loader/app_circular_progress_indicator.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../../../../core/widget/text/app_text.dart';
import '../../../../core/widget/text_form_field/outline_text_form_field.dart';
import '../../../../router/app_router.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/9/2024.
 */

class BookingForm extends StatefulWidget {
  const BookingForm(
      {super.key,
      required this.subActivityArName,
      required this.subActivityEnName,
      required this.collectionName});

  final String subActivityArName, subActivityEnName, collectionName;
  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  List<TextEditingController> controllers = [];
  List<GlobalKey<FormState>> formKeys = [];
  String phoneNumber = '';
  GlobalKey<FormState> phoneNumberFromKey = GlobalKey<FormState>();

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
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColor.lightGrey,
                blurRadius: 25,
                offset: const Offset(1, 9))
          ]),
      child: Column(
        children: [
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text:
                "${"toBookingFor".tr()} ${LanguageHelper.isEnglishAppLanguage() ? widget.subActivityEnName : widget.subActivityArName} ${"fillOutTheFollowingForm".tr()}",
            fontWeight: FontWeight.bold,
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
              focusedBorderColor: AppColor.darkOrange,
              enabledBorderColor: AppColor.grey),
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
              focusedBorderColor: AppColor.darkOrange,
              enabledBorderColor: AppColor.grey),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          PhoneNumberWidget(
              isOnlySA: false,
              formKey: phoneNumberFromKey,
              onPhoneNumberChanged: (phone) {
                phoneNumber = phone;
              }),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "numberOfPerson".tr(),
              controller: controllers[2],
              formKey: formKeys[2],
              textInputType: TextInputType.number,
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
              focusedBorderColor: AppColor.darkOrange,
              enabledBorderColor: AppColor.grey),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          OutlineTextFormField(
              hint: "note".tr(),
              controller: controllers[3],
              formKey: formKeys[3],
              validator: (value) {
                return null;
              },
              textAlignVertical: TextAlignVertical.top,
              edgeInsets: EdgeInsets.symmetric(
                  horizontal: AppWidthSize.w3point8,
                  vertical: AppHeightSize.h3),
              focusedBorderColor: AppColor.darkOrange,
              enabledBorderColor: AppColor.grey),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          BlocConsumer<AddBookingCubit, AddBookingState>(
            listener: (context, state) {
              if (state.status == CubitStatus.error) {
                NoteMessage.showErrorSnackBar(
                    context: context, text: state.model.error??"");
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

                    context.read<AddBookingCubit>().addBooking(body: {
                      "full_name": controllers[0].text,
                      "email": controllers[1].text,
                      "phone_number": phoneNumber,
                      "number_of_person": controllers[2].text,
                      "note": controllers[3].text,
                      "ar_place": widget.subActivityArName,
                      "en_place": widget.subActivityEnName,
                      "collection_name": widget.collectionName,
                      "status": "pending"
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
        (phoneNumberFromKey.currentState?.validate() ?? false);
    return isOk && isPhoneNumberOk;
  }
}
