import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/error/error_text.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/snack_bar/note_message.dart';
import 'package:mo_wahaj_top/features/main/cubit/home_cubit/home_cubit.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/ads_list.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/banner_item.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/dot_indicator_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/widget/footer/contact_us_footer.dart';
import '../widget/home/activity_grid_list.dart';
import '../widget/home/most_banner_widget.dart';
import '../widget/home/other_activity_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == CubitStatus.error) {
          NoteMessage.showErrorSnackBar(
              context: context, text: state.model.error ?? "");
        }

        if (state.status == CubitStatus.success) {
          HomeViewFactory.init(data: state.model.data ?? {});
        }
      },
      builder: (context, state) {
        HomeViewFactory.resetIndex();

        if (state.status == CubitStatus.loading) {
          return Center(
            child: AppCircularProgressIndicator(),
          );
        }

        if (state.status == CubitStatus.error) {
          return ErrorText(error: state.model.error ?? "");
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().getHome();
          },
          child: SingleChildScrollView(
            child: Column(
              children: HomeViewFactory.buildListOfWidget(
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                currentIndex: _currentIndex,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    HomeViewFactory.resetIndex();
    super.dispose();
  }
}

abstract class HomeViewFactory {
  static late Map<String, dynamic> factoryData;
  static List<num>? factoryShowMapCode;
  static bool showFirstLaunchMessage = false;

  static const num bannerWidgetCode = 0;
  static const num categoryWidgetCode = 1;
  static const num adsWidgetCode = 2;
  static const num activityWidgetCode = 3;
  static const num emptyWidget = 4;

  static int _bannerIndex = 0;
  static int _categoryIndex = 0;
  static int _adsIndex = 0;
  static int _activityIndex = 0;
  static int currentIndex = 0;

  static void init(
      {required Map<String, dynamic> data, List<num>? showMapCode}) {
    resetIndex();
    factoryData = data;
    factoryShowMapCode = showMapCode ?? data['show_map'].cast<num>();
    showFirstLaunchMessage = data['show_first_launch_message'] ?? false;
  }

  static resetIndex() {
    _bannerIndex = 0;
    _categoryIndex = 0;
    _adsIndex = 0;
    _activityIndex = 0;
    currentIndex = 0;
  }

  static List<Widget> buildListOfWidget({
    required Function(int) onPageChanged,
    required int currentIndex,
  }) {
    List<Widget> widgetList = [
      _buildEmptyWidget(),
    ];

    if (showFirstLaunchMessage == true) {
      // widgetList.add(_buildTestMessage());
      widgetList.add(_buildEmptyWidget());
    }

    for (num it in factoryShowMapCode ?? []) {
      widgetList.add(_buildWidget(
        widgetCode: it,
        onPageChanged: onPageChanged,
        currentIndex: currentIndex,
      ));
      widgetList.add(_buildWidget(
        widgetCode: emptyWidget,
        onPageChanged: onPageChanged,
        currentIndex: currentIndex,
      ));
    }

    widgetList.add(_buildContactUsWidget());
    return widgetList;
  }

  static Widget _buildWidget({
    required num widgetCode,
    required Function(int) onPageChanged,
    required int currentIndex,
  }) {
    switch (widgetCode) {
      case bannerWidgetCode:
        return _buildBannerWidget(
          onPageChanged: onPageChanged,
          currentIndex: currentIndex,
        );
      case categoryWidgetCode:
        return _buildCategoryWidget();
      case activityWidgetCode:
        return _buildActivityWidget();
      case adsWidgetCode:
        return _buildAdsWidget();
      case emptyWidget:
        return _buildEmptyWidget();
      default:
        return const SizedBox();
    }
  }

  static Widget _buildBannerWidget({
    required Function(int) onPageChanged,
    required int currentIndex,
  }) {
    List<Map<String, dynamic>> bannersData =
        (factoryData['banners'] ?? []).cast<Map<String, dynamic>>();

    List<Map<String, dynamic>> bannersVisibleData =
        bannersData.where((element) => element['is_visible'] == true).toList();

    if (bannersVisibleData.length == 1) {
      return AspectRatio(
        aspectRatio: 2052 / 1080,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
          child: BannerItem(
              action: bannersVisibleData.first['action'] ?? "",
              url: bannersVisibleData.first['url'] ?? "",
              enName: bannersVisibleData.first['en_name'] ?? "",
              subActivityObj: bannersVisibleData.first,
              activityObj: bannersVisibleData.first,
              image: bannersVisibleData.first['image'] ?? ""),
        ),
      );
    }
    return Visibility(
      visible: bannersVisibleData.isNotEmpty,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              aspectRatio: 2052 / 1080,
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
            items: bannersVisibleData.map((item) {
              return BannerItem(
                  action: item['action'] ?? "",
                  url: item['url'] ?? "",
                  enName: item['en_name'] ?? "",
                  subActivityObj: item,
                  activityObj: item,
                  image: item['image'] ?? "");
            }).toList(),
          ),
          const SizedBox(
            height: 8,
          ),
          DotIndicatorWidget(
            currentIndex: currentIndex, // Sync currentIndex with the carousel
            count: bannersVisibleData.length,
          ),
        ],
      ),
    );
  }

  static Widget _buildCategoryWidget() {
    List<Map<String, dynamic>> categoriesData =
        (factoryData['categories'] ?? []).cast<Map<String, dynamic>>();

    if (_categoryIndex >= categoriesData.length) return const SizedBox();

    String title = LanguageHelper.isEnglishAppLanguage()
        ? categoriesData[_categoryIndex]['en_title'] ?? ""
        : categoriesData[_categoryIndex]['ar_title'] ?? "";

    bool isCategoryVisible =
        categoriesData[_categoryIndex]['is_visible'] ?? false;

    Map<String, dynamic> categoryData =
        (categoriesData[_categoryIndex]['category']);

    List<Map<String, dynamic>> categoriesItem =
        (categoryData['category_item'] ?? []).cast<Map<String, dynamic>>();

    _categoryIndex++;
    return Visibility(
      visible: categoriesItem.isNotEmpty && isCategoryVisible == true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
        child: ActivityList(
          title: title,
          data: categoriesItem,
        ),
      ),
    );
  }

  static Widget _buildAdsWidget() {
    List<Map<String, dynamic>> adsData =
        (factoryData['ads'] ?? []).cast<Map<String, dynamic>>();

    if (_adsIndex >= adsData.length) return const SizedBox();
    List<Map<String, dynamic>> adData = [];
    bool isAdsVisible = false;
    if (adsData.isNotEmpty) {
      isAdsVisible = adsData[_adsIndex]['is_visible'] ?? false;
      adData = (adsData[_adsIndex]['ad'] ?? []).cast<Map<String, dynamic>>();
    }

    _adsIndex++;
    return Visibility(
        visible: adData.isNotEmpty && isAdsVisible == true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
              child: MostBannerWidget(
                title: "trendingPlaces",
                title1: "seeAll",
                onTap: () {},
              ),
            ),
            SizedBox(height: 2.h),
            AdsList(
              adData: adData,
            ),
          ],
        ));
  }

  static Widget _buildActivityWidget() {
    List<Map<String, dynamic>> activitiesData =
        (factoryData['activities'] ?? []).cast<Map<String, dynamic>>();

    if (_activityIndex >= activitiesData.length) return const SizedBox();

    List<Map<String, dynamic>> activityData = [];
    bool isActivityVisible =
        activitiesData[_activityIndex]['is_visible'] ?? false;
    if (activitiesData.isNotEmpty) {
      activityData =
          ((activitiesData[_activityIndex]['activity'] ?? []) as List)
              .cast<Map<String, dynamic>>();
    }

    String enName = activitiesData[_activityIndex]['en_activity_title'] ?? "";
    String arName = activitiesData[_activityIndex]['ar_activity_title'] ?? "";
    _activityIndex++;
    return Visibility(
        visible: activityData.isNotEmpty && isActivityVisible == true,
        child: OtherActivityList(
          activityData: activityData,
          title: LanguageHelper.isEnglishAppLanguage() ? enName : arName,
        ));
  }

  static Widget _buildContactUsWidget() {
    return const ContactUsFooter();
  }

  static Widget _buildEmptyWidget() {
    return SizedBox(
      height: AppHeightSize.h2,
    );
  }

// static Widget _buildTestMessage() {
//   return Container(
//     width: AppWidthSize.w60,
//     margin: EdgeInsets.symmetric(
//         horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h1),
//     padding: EdgeInsets.symmetric(
//         horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h1),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(width: 2, color: AppColor.purple)),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//
//         AppText(
//           text: "firstLaunch".tr(),
//           fontColor: AppColor.purple,
//           fontWeight: FontWeight.w600,
//           fontSize: AppFontSize.sp16,
//         ),
//       ],
//     ),
//   );
// }
}
