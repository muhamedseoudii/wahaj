import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/features/account/cubit/bookings_cubit/bookings_cubit.dart';

import '../../../../core/resource/app_icon.dart';
import '../../../../core/resource/cubit_status.dart';
import '../../../../core/widget/loader/app_circular_progress_indicator.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../../../../core/widget/text/app_text.dart';
import '../widget/booking_history_item.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/9/2024.
 */

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
      ),
      body: BlocConsumer<BookingsCubit, BookingsState>(
        listener: (context, state) {
          if (state.status == CubitStatus.error) {
            NoteMessage.showErrorSnackBar(context: context, text: state.model.error??"");
          }
        },
        builder: (context, state) {
          if (state.status == CubitStatus.loading) {
            return Center(
              child: AppCircularProgressIndicator(),
            );
          }

          List<Map<String, dynamic>> bookings =
              (state.model.data?['bookings'] ?? [])
                  .cast<Map<String, dynamic>>();
          return Visibility(
            visible: bookings.isNotEmpty,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          AppIcon.emptyBooking,
                          width: AppWidthSize.w30,
                          height: AppWidthSize.w30,
                          colorFilter: const ColorFilter.mode(
                              AppColor.purple, BlendMode.srcIn),
                        ),
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                        AppText(
                          text: "emptyBooking".tr(),
                          fontSize: AppFontSize.sp17,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColor.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      bottom: AppHeightSize.h5, top: AppHeightSize.h2),
                  itemBuilder: (context, index) => BookingHistoryItem(
                        note: bookings[index]['note'] ?? "",
                        email: bookings[index]['email'] ?? "",
                        phoneNumber: bookings[index]['phone_number'] ?? "",
                        fullName: bookings[index]['full_name'] ?? "",
                        numberOfPerson:
                            bookings[index]['number_of_person'] ?? "",
                        place: LanguageHelper.isEnglishAppLanguage()
                            ? bookings[index]['en_place'] ?? ""
                            : bookings[index]['ar_place'] ?? "",
                        status: bookings[index]['status'] ?? "",
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppHeightSize.h2,
                      ),
                  itemCount: bookings.length),
            ),
          );
        },
      ),
    );
  }
}
