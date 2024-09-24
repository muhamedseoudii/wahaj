import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/navigation/fade_builder_route.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/features/account/cubit/bookings_cubit/bookings_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/notification_cubit/notificaiton_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/booking_history_screen.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/favorite_list_screen.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/notificaiton_screen.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_booking_cubit/add_booking_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_favorite_cubit/add_favorite_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/screen/booking_screen.dart';
import 'package:mo_wahaj_top/features/activity/presentation/screen/sub_activity_screen.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/about_us_cubit/about_us_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/add_business_cubit/add_business_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/contact_us_cubit/contact_us_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/places_cubit/places_cubit.dart';
import 'package:mo_wahaj_top/features/account/cubit/submit_message_cubit/submit_message_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/contact_us_screen.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/places_screen.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/privacy_policy_screen.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/send_code_cubit/send_code_cubit.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/verifiy_code_cubit/verifiy_code_cubit.dart';
import 'package:mo_wahaj_top/features/auth/presentation/screen/verification_code_screen.dart';
import 'package:mo_wahaj_top/features/intro/cubit/launch_type_cubit/launch_type_cubit.dart';
import 'package:mo_wahaj_top/features/intro/presentation/screen/splash_screen.dart';
import 'package:mo_wahaj_top/features/main/cubit/delete_user_cubit/delete_user_cubit.dart';
import 'package:mo_wahaj_top/features/main/cubit/discounts_cubit/offers_cubit.dart';
import 'package:mo_wahaj_top/features/main/cubit/home_cubit/home_cubit.dart';
import 'package:mo_wahaj_top/features/main/presentation/screen/main_screen.dart';
import 'package:mo_wahaj_top/features/search/cubit/search_cubit/search_cubit.dart';
import 'package:mo_wahaj_top/features/search/presentation/screen/search_screen.dart';
import 'package:mo_wahaj_top/features/web_view/presentation/screen/web_view_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../features/activity/presentation/cubit/sub_activity_ads_cubit/sub_activity_ads_cubit.dart';
import '../features/activity/presentation/cubit/sub_activity_cubit/sub_activity_cubit.dart';
import '../features/activity/presentation/screen/map_screen.dart';
import '../features/activity/presentation/screen/sub_activity_details_screen.dart';
import '../features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import '../features/auth/presentation/cubit/sign_cubit/sign_cubit.dart';
import '../features/auth/presentation/screen/auth_screen.dart';
import '../features/account/cubit/privacy_policy_cubit/privacy_policy_cubit.dart';
import '../features/account/presentation/screen/about_us_screen.dart';
import '../features/account/presentation/screen/add_business_screen.dart';
import '../features/main/cubit/activities_cubit/activities_cubit.dart';

abstract class RouteName {
  static const init = splash;
  static const splash = "/splash";
  static const webView = "/web-view";
  static const main = "/main";
  static const aboutUs = "/about-us";
  static const auth = "/auth";
  static const verifyCode = "/verify-code";
  static const places = "/places";
  static const contactUs = "/contact-us";
  static const privacyPolicy = "/privacy-policy";
  static const addBusiness = "/add-business";
  static const search = "/search";
  static const subActivity = "/sub-activity";
  static const subActivityDetails = "/sub-activity-details";
  static const booking = "/booking";
  static const bookingHistory = "/booking-history";
  static const map = "/map";
  static const notification = "/notification";
  static const favorite = "/favorite";
  static const placesDetails = "/placesDetails";
}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return FadeBuilderRoute(
            page: BlocProvider(
                create: (context) => LaunchTypeCubit()..getLaunchType(),
                child: const SplashScreen()));
      case RouteName.webView:
        WebViewArgs? args = settings.arguments as WebViewArgs?;
        return FadeBuilderRoute(
            page: WebViewScreen(
          args: args,
        ));
      case RouteName.main:
        MainArgs? mainArgs;
        if (settings.arguments is MainArgs) {
          mainArgs = settings.arguments as MainArgs;
        }
        return FadeBuilderRoute(
            page: MultiBlocProvider(
                providers: [
              BlocProvider(
                create: (context) => ContactUsCubit()..getContactUs(),
              ),
              BlocProvider(
                create: (context) => HomeCubit()..getHome(),
              ),
              BlocProvider(
                create: (context) => ActivitiesCubit()..getActivities(),
              ),
              BlocProvider(
                create: (context) => OffersCubit()..getOffers(),
              ),
              BlocProvider(
                create: (context) => DeleteUserCubit(),
              ),
            ],
                child: MainScreen(
                  args: mainArgs ?? MainArgs(openIndex: 0),
                )));
      case RouteName.aboutUs:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => AboutUsCubit()..getAboutUs(),
          ),
        ], child: const AboutUsScreen()));
      case RouteName.auth:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordCubit(),
          ),
          BlocProvider(
            create: (context) => SendCodeCubit(),
          ),
        ], child: const AuthScreen()));
      case RouteName.verifyCode:
        VerificationCodeArgs args = settings.arguments as VerificationCodeArgs;
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => VerifyCodeCubit(),
          ),
          BlocProvider(
            create: (context) => SendCodeCubit(),
          ),
        ], child: VerificationCodeScreen(args: args)));
      case RouteName.places:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => PlacesCubit()..getPlaces(),
          ),
        ], child: const PlacesScreen()));
      case RouteName.contactUs:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => ContactUsCubit()..getContactUs(),
          ),
          BlocProvider(
            create: (context) => SubmitMessageCubit(),
          ),
        ], child: const ContactUsScreen()));
      case RouteName.privacyPolicy:
        return FadeBuilderRoute(
            page: BlocProvider(
                create: (context) => PrivacyPolicyCubit()..getPrivacyPolicy(),
                child: const PrivacyPolicyScreen()));
      case RouteName.addBusiness:
        return FadeBuilderRoute(
            page: BlocProvider(
                create: (context) => AddBusinessCubit(),
                child: const AddBusinessScreen()));
      case RouteName.subActivity:
        SubActivityArgs args = settings.arguments as SubActivityArgs;
        return FadeBuilderRoute(
            page: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ContactUsCubit()..getContactUs(),
            ),
            BlocProvider(
              create: (context) => SubActivityCubit()
                ..getSubActivities(activityCollectionName: args.collectionName),
            ),
            BlocProvider(
              create: (context) => SubActivityAdsCubit()
                ..getSubActivityAds(
                    activityAdsCollectionName: args.adsCollectionName),
            ),
          ],
          child: SubActivityScreen(
            args: args,
          ),
        ));
      case RouteName.subActivityDetails:
        SubActivityDetailsArgs args =
            settings.arguments as SubActivityDetailsArgs;
        return FadeBuilderRoute(
            page: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddFavoriteCubit(),
            )
          ],
          child: SubActivityDetailsScreen(
            args: args,
          ),
        ));
      case RouteName.booking:
        BookingArgs args = settings.arguments as BookingArgs;
        return FadeBuilderRoute(
            page: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AddBookingCubit()),
          ],
          child: BookingScreen(
            args: args,
          ),
        ));
      case RouteName.map:
        MapArgs args = settings.arguments as MapArgs;
        return FadeBuilderRoute(
            page: MapScreen(
          args: args,
        ));
      case RouteName.notification:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => NotificationCubit()..getNotification(),
          )
        ], child: const NotificationScreen()));
      case RouteName.bookingHistory:
        return FadeBuilderRoute(
            page: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => BookingsCubit()..getBookings(),
          )
        ], child: const BookingHistoryScreen()));
      case RouteName.search:
        return FadeBuilderRoute(
            page: BlocProvider(
                create: (context) => SearchCubit(),
                child: const SearchScreen()));

      case RouteName.favorite:
        return FadeBuilderRoute(
            page: BlocProvider(
                create: (context) => FavoriteCubit()..getFavoriteList(),
                child: const FavoriteListScreen()));
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: AppColor.background,
            body: Center(
                child: Text(
              "Page Not Found",
              style: TextStyle(fontSize: 20.sp, color: Colors.red[700]),
            )),
          ),
        );
    }
  }
}
