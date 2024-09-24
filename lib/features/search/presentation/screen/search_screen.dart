import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/features/search/cubit/search_cubit/search_cubit.dart';
import 'package:mo_wahaj_top/features/search/presentation/widget/places_tab_view.dart';
import '../../../../core/widget/loader/app_circular_progress_indicator.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../../../../core/widget/text/app_text.dart';
import '../../../main/presentation/widget/home/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  late TextEditingController controller;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
            child: SearchTextField(
              controller: controller,
              textInputType: TextInputType.text,
              onSubmitted: (value) {
                context.read<SearchCubit>().search(searchKey: value);
              },
              onSearch: () {
                context.read<SearchCubit>().search(searchKey: controller.text);
              },
            ),
          ),
          SizedBox(
            height: AppHeightSize.h5,
          ),
          Expanded(
            child: BlocConsumer<SearchCubit, SearchState>(
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

                List<Map<String, dynamic>> places =
                    (state.model.data?['places'] ?? [])
                        .cast<Map<String, dynamic>>();

                if (places.isEmpty) {
                  return Center(
                      child: AppText(
                    text: "thereIsNoPlacesToShow".tr(),
                    fontColor: AppColor.purple,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFontSize.sp16,
                  ));
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w1),
                  child: PlacesTabView(
                    places: places,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }
}
