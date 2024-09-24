import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_error_handler.dart';

/// Created by Eng.Eyad AlSayed on 5/15/2024.

abstract class FireStoreCollectionName {
  static const String signUp = "signUp";
  static const String login = "login";
  static const String forgotPassword = "forgot-password";
  static const String info = "info";
  static const String appConfig = "app-config";
  static const String messages = "messages";
  static const String booking = "booking";
  static const String favorite = "favorite";
  static const String businessMessage = "business-message";
}

abstract class FireStoreDocumentName {
  static const String aboutUs = "about-us";
  static const String privacyPolicy = "privacy-policy";
  static const String contactUs = "contact-us";
  static const String places = "places";
  static const String home = "home";
  static const String activities = "activities";
  static const String activityViews = "activity-views";
  static const String offers = "offers";
  static const String notification = "notification";
  static const String subActivities = "sub-activities";
  static const String subActivityAds = "ads";
  static const String launchType = "launch-type";
  static const String signUpEmail = "signup-email";
  static const String signUpPhone = "signup-phone";
}

abstract class FireStoreGetMethod {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<FireStoreBaseModel> getPrivacyPolicy() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.privacyPolicy)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getPlaces() {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.places)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getContactUs() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.contactUs)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getAboutUs() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.aboutUs)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getLaunchType() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.appConfig)
            .doc(FireStoreDocumentName.launchType)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getHome() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.home)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getActivities() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activities)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getAllSubActivities() {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        // Reference to the parent document
        DocumentReference parentDocRef = _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activities);

        // Reference to the sub-collection
        CollectionReference subCollectionRef =
            parentDocRef.collection('your_sub_collection');

        // Get the documents from the sub-collection
        QuerySnapshot subCollectionSnapshot = await subCollectionRef.get();

        // Iterate through the documents
        subCollectionSnapshot.docs.forEach((doc) {
          print(doc.id); // Print the document ID
          print(doc.data()); // Print the document data
        });

        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activities)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getOffers() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activities)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getSubActivity(
      {required String activityCollectionName}) async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(
                "${FireStoreCollectionName.info}/${FireStoreDocumentName.activities}/$activityCollectionName")
            .doc(FireStoreDocumentName.subActivities)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getSubActivityAds(
      {required String activityCollectionName}) async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(
                "${FireStoreCollectionName.info}/${FireStoreDocumentName.activities}/$activityCollectionName")
            .doc(FireStoreDocumentName.subActivityAds)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> search() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.places)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getNotification() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.notification)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getBookings(
      {required String username}) async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.booking)
            .doc(username)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getFavoriteList(
      {required String username}) async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.favorite)
            .doc(username)
            .get();
      },
    );
  }

  static Future<FireStoreBaseModel> getActivityViews() async {
    return FireStoreGetMethodErrorHandler.handleError(
      call: () async {
        return await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activityViews)
            .get();
      },
    );
  }
}

abstract class FireStoreAddMethod {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FireStoreBaseModel> signUp(
      {required Map<String, dynamic> body}) async {
    return FireAuthMethodErrorHandler.handleError(
      call: () async {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: body['email'] ?? "",
          password: body['password'] ?? "",
        );
      },
    );
  }

  static Future<FireStoreBaseModel> login(
      {required Map<String, dynamic> body}) async {
    return FireAuthMethodErrorHandler.handleError(
      call: () async {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: body['email'] ?? "",
          password: body['password'] ?? "",
        );
      },
    );
  }

  static Future<FireStoreBaseModel> forgotPassword(
      {required Map<String, dynamic> body}) async {
    return FireAuthMethodErrorHandler.handleError(
      call: () async {
        await _auth.sendPasswordResetEmail(
          email: body['email'] ?? "",
        );
      },
    );
  }

  static Future<FireStoreBaseModel> sendCode(
      {required Map<String, dynamic> body}) async {
    String? verificationId;
    bool? isOtpSent;
    FireStoreBaseModel model = FireStoreBaseModel();
    model = await FireAuthMethodErrorHandler.handleError(
      call: () async {
        await _auth.verifyPhoneNumber(
          phoneNumber: body['phone_number'],
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            model.error = handleFirebaseAuthError(exception: e);
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationId = verificationId;
            isOtpSent = true;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
        );
      },
    );

    model.data?['verificationId'] = verificationId;
    model.data?['isOtpSent'] = isOtpSent;
    return model;
  }

  static Future<FireStoreBaseModel> verifyCode(
      {required Map<String, dynamic> body}) async {
    return FireAuthMethodErrorHandler.handleError(call: () async {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: body['verificationId'] ?? "",
        smsCode: body['otp'] ?? "",
      );
      await _auth.signInWithCredential(credential);

      FireStoreAddMethodErrorHandler.handleError(
        call: () async {
          await _instance
              .collection(FireStoreCollectionName.signUp)
              .doc(FireStoreDocumentName.signUpPhone)
              .update(
            {body['phone_number']: DateTime.now().toLocal().toString()},
          );
        },
      );
    });
  }

  static Future<FireStoreBaseModel> submitMessage(
      {Map<String, dynamic> body = const {}}) async {
    return FireStoreAddMethodErrorHandler.handleError(
      call: () async {
        await _instance.collection(FireStoreCollectionName.messages).add(body);
      },
    );
  }

  static Future<FireStoreBaseModel> addActivityView(
      {Map<String, dynamic> body = const {}}) async {
    FireStoreBaseModel activityViewModel =
        await FireStoreGetMethod.getActivityViews();

    String activityName = body['activity_name'] ?? "";
    String image = body['image'] ?? "";
    bool isOutView = body['out_view'] ?? false;
    bool isInView = body['in_view'] ?? false;
    bool isCallAction = body['call_action'] ?? false;
    bool isWhatsappAction = body['whatsapp_action'] ?? false;
    bool isFacebookAction = body['facebook_action'] ?? false;
    bool isInstagramAction = body['instagram_action'] ?? false;
    bool isMapAction = body['map_action'] ?? false;
    bool isWebsiteAction = body['map_action'] ?? false;
    bool isTiktokAction = body['map_action'] ?? false;
    bool isSnapchatAction = body['map_action'] ?? false;
    List<Map<String, dynamic>> views =
        (activityViewModel.data?['views'] ?? []).cast<Map<String, dynamic>>();

    bool isOk = false;
    for (Map<String, dynamic> element in views) {
      if (element['activity_name'] == activityName) {
        if (isOutView == true) {
          int oldOutView = int.parse(element['out_view'] ?? "0");
          element['out_view'] = (oldOutView + 1).toString();
        }
        if (isInView == true) {
          int oldInView = int.parse(element['in_view'] ?? "0");
          element['in_view'] = (oldInView + 1).toString();
        }

        if (isCallAction == true) {
          int oldInView = int.parse(element['call_action'] ?? "0");
          element['call_action'] = (oldInView + 1).toString();
        }
        if (isWhatsappAction == true) {
          int oldInView = int.parse(element['whatsapp_action'] ?? "0");
          element['whatsapp_action'] = (oldInView + 1).toString();
        }

        if (isFacebookAction == true) {
          int oldInView = int.parse(element['facebook_action'] ?? "0");
          element['facebook_action'] = (oldInView + 1).toString();
        }

        if (isInstagramAction == true) {
          int oldInView = int.parse(element['instagram_action'] ?? "0");
          element['instagram_action'] = (oldInView + 1).toString();
        }
        if (isMapAction == true) {
          int oldInView = int.parse(element['map_action'] ?? "0");
          element['map_action'] = (oldInView + 1).toString();
        }

        if (isWebsiteAction == true) {
          int oldInView = int.parse(element['website_action'] ?? "0");
          element['website_action'] = (oldInView + 1).toString();
        }

        if (isTiktokAction == true) {
          int oldInView = int.parse(element['tiktok_action'] ?? "0");
          element['tiktok_action'] = (oldInView + 1).toString();
        }

        if (isSnapchatAction == true) {
          int oldInView = int.parse(element['snapchat_action'] ?? "0");
          element['snapchat_action'] = (oldInView + 1).toString();
        }

        isOk = true;
        break;
      }
    }

    if (isOk == false) {
      views.add({
        "out_view": "1",
        "in_view": "1",
        "call_action": "1",
        "whatsapp_action": "1",
        "facebook_action": "1",
        "instagram_action": "1",
        "map_action": "1",
        "website_action": "1",
        "tiktok_action": "1",
        "snapchat_action": "1",
        "activity_name": activityName,
        "image": image
      });
    }

    activityViewModel.data?['views'] = views;

    return FireStoreAddMethodErrorHandler.handleError(
      call: () async {
        await _instance
            .collection(FireStoreCollectionName.info)
            .doc(FireStoreDocumentName.activityViews)
            .set(activityViewModel.data ?? {}, SetOptions(merge: true));
      },
    );
  }

  static Future<FireStoreBaseModel> addBooking(
      {Map<String, dynamic> body = const {}, required String username}) async {
    return FireStoreAddMethodErrorHandler.handleError(
      call: () async {
        DocumentSnapshot documentSnapshot = await _instance
            .collection(FireStoreCollectionName.booking)
            .doc(username)
            .get();

        Object? existingList = documentSnapshot.data();

        List<Map<String, dynamic>> tmpList = [];
        if (existingList == null) {
          tmpList.add(body);
        } else {
          tmpList = ((existingList as Map<String, dynamic>)['bookings'] ?? [])
              .cast<Map<String, dynamic>>();
        }

        tmpList.add(body);
        await _instance
            .collection(FireStoreCollectionName.booking)
            .doc(username)
            .set({"bookings": tmpList}, SetOptions(merge: true));
      },
    );
  }

  static Future<FireStoreBaseModel> addFavorite(
      {Map<String, dynamic> body = const {}, required String username}) async {
    return FireStoreAddMethodErrorHandler.handleError(
      call: () async {
        DocumentSnapshot documentSnapshot = await _instance
            .collection(FireStoreCollectionName.favorite)
            .doc(username)
            .get();

        bool isFavorite = body['is_favorite'] ?? false;
        String activityName = body['activity_name'] ?? '';

        Object? existingList = documentSnapshot.data();

        List<Map<String, dynamic>> tmpList = [];
        if (existingList == null) {
          tmpList.add(body);
        } else {
          tmpList = ((existingList as Map<String, dynamic>)['favorites'] ?? [])
              .cast<Map<String, dynamic>>();

          bool isExited = false;
          for (Map<String, dynamic> it in tmpList) {
            if ((it['activity_name'] ?? '') == activityName &&
                isFavorite == false) {
              tmpList.remove(it);
              isExited = true;
            }
          }

          if (isExited == false) {
            tmpList.add(body);
          }
        }

        await _instance
            .collection(FireStoreCollectionName.favorite)
            .doc(username)
            .set({"favorites": tmpList}, SetOptions(merge: true));
      },
    );
  }

  static Future<FireStoreBaseModel> addYourBusiness(
      {Map<String, dynamic> body = const {}}) async {
    return FireStoreAddMethodErrorHandler.handleError(call: () async {
      DocumentReference<Map<String, dynamic>> response = await _instance
          .collection(FireStoreCollectionName.businessMessage)
          .add(body);
    });
  }
}

abstract class FireStoreDeleteMethod {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FireStoreBaseModel> deleteUser(
      {required Map<String, dynamic> body}) async {
    FireStoreBaseModel model = FireStoreBaseModel();

    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      model.code = 1;
      model.error = "${"errorOccurred".tr()} : $e";
      return model;
    }

    model.code = 0;
    model.data = {};
    return model;
  }
}
