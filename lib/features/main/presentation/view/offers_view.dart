import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/snack_bar/note_message.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/main/cubit/discounts_cubit/offers_cubit.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/26/2024.
 */

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) {
        if(state.status == CubitStatus.error){
          NoteMessage.showErrorSnackBar(context: context, text: state.model.error??"");
        }
      },
      builder: (context, state) {

        if(state.status == CubitStatus.loading){
          return Center(child: AppCircularProgressIndicator(),);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: "thereAreNoOffersYet".tr(),
                  fontSize: AppFontSize.sp16,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColor.purple,
                ),
              ],
            ),
            SizedBox(
              height: AppWidthSize.w3point8,
            ),
            SvgPicture.asset(
              AppIcon.offerPrecentag,
              width: AppWidthSize.w20,
              height: AppWidthSize.w20,
              colorFilter: const ColorFilter.mode(
                  AppColor.purple, BlendMode.srcIn),
            )
          ],
        );
      },
    );
  }
}
