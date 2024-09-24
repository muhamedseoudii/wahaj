import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'firestore_base_model.dart';

abstract class FireStoreGetMethodErrorHandler {
  static Future<FireStoreBaseModel> handleError(
      {required Future<DocumentSnapshot<Map<String, dynamic>>> Function()
          call}) async {
    FireStoreBaseModel model = FireStoreBaseModel();
    DocumentSnapshot<Map<String, dynamic>>? doc;
    try {
      doc = await call();
    } on FirebaseException catch (e) {
      model.code = 1;
      model.error = handleFirebaseError(exception: e);
      return model;
    } on PlatformException catch (e) {
      model.code = 2;
      model.error = handlePlatformError(exception: e);
      return model;
    } catch (e) {
      model.code = 3;
      model.error = handleGeneralExceptionError(exception: e);
      return model;
    }

    model.code = 0;
    model.data = doc.data();
    return model;
  }
}

abstract class FireStoreAddMethodErrorHandler {
  static Future<FireStoreBaseModel> handleError(
      {required Future<void> Function() call}) async {
    FireStoreBaseModel model = FireStoreBaseModel();
    try {
      await call();
    } on FirebaseException catch (e) {
      model.code = 1;
      model.error = handleFirebaseError(exception: e);
      return model;
    } on PlatformException catch (e) {
      model.code = 2;
      model.error = handlePlatformError(exception: e);
      return model;
    } catch (e) {
      model.code = 3;
      model.error = handleGeneralExceptionError(exception: e);
      return model;
    }

    model.code = 0;
    model.data = {};
    return model;
  }
}

abstract class FireAuthMethodErrorHandler {
  static Future<FireStoreBaseModel> handleError(
      {required Future<void> Function() call}) async {
    FireStoreBaseModel model = FireStoreBaseModel();
    try {
      await call();
    } on FirebaseAuthException catch (e) {
      model.code = 1;
      model.error = handleFirebaseAuthError(exception: e);
      return model;
    } on PlatformException catch (e) {
      model.code = 2;
      model.error = handlePlatformError(exception: e);
      return model;
    } catch (e) {
      model.code = 3;
      model.error = handleGeneralExceptionError(exception: e);
      return model;
    }

    model.code = 0;
    model.data = {};
    return model;
  }
}

String handleFirebaseError({required FirebaseException exception}) {
  switch (exception.code) {
    case 'permission-denied':
      return "youDoNotHavePermissionToPerformThisAction".tr();
    case 'unavailable':
      return "thisServiceIsCurrentlyUnavailable".tr();
    default:
      return "${"anUnknownFirebaseErrorOccurred".tr()} : ${exception.message}'";
  }
}

String handleFirebaseAuthError({required FirebaseException exception}) {
  switch (exception.code) {
    case "user-not-found":
      return "noUserFoundForThatEmail".tr();
    case "wrong-password":
      return "wrongPasswordProvided".tr();
    case "invalid-verification-code":
      return "invalidVerificationCode".tr();
    default:
      return 'authenticationError: ${exception.message}';
  }
}

String handlePlatformError({required PlatformException exception}) {
  return "${"aPlatformErrorOccurred".tr()} : ${exception.message}";
}

String handleGeneralExceptionError({required Object exception}) {
  return "anUnknownErrorOccurred".tr();
}
