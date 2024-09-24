import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/footer/contact_us_footer.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/features/activity/presentation/screen/sub_activity_screen.dart';
import 'package:mo_wahaj_top/features/main/cubit/activities_cubit/activities_cubit.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/widget/snack_bar/note_message.dart';
import '../widget/home/activity_item.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
      listener: (context, state) {
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

        List<Map<String, dynamic>> activitiesData =
            (state.model.data?['activities'] ?? [])
                .cast<Map<String, dynamic>>();

        List<Map<String, dynamic>> activitiesDataVisible = activitiesData
            .where((element) => element['is_visible'] == true)
            .toList();

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ActivitiesCubit>().getActivities();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: AppHeightSize.h2),
                      crossAxisCount: 2,
                      mainAxisSpacing: AppWidthSize.w6,
                      crossAxisSpacing: AppWidthSize.w3,
                      childAspectRatio: 0.76,
                      children:
                          List.generate(activitiesDataVisible.length, (index) {
                        return ActivityItem(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteName.subActivity,
                                  arguments: SubActivityArgs(
                                      subActivityArName:
                                          activitiesDataVisible[index]
                                                  ['ar_name'] ??
                                              "",
                                      subActivityEnName:
                                          activitiesDataVisible[index]
                                                  ['en_name'] ??
                                              "",
                                      adsCollectionName:
                                          activitiesDataVisible[index]
                                                  ['ads_collection_name'] ??
                                              "",
                                      collectionName:
                                          activitiesDataVisible[index]
                                                  ['collection_name'] ??
                                              ""));
                            },
                            activitiesData: activitiesDataVisible[index]);
                      }),
                    )),
                const ContactUsFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
