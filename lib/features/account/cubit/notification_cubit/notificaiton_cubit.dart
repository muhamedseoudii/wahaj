import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';

import '../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../core/resource/cubit_status.dart';

part 'notificaiton_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.initial());

  void getNotification() async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreGetMethod.getNotification();

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error,model: model));
    }
  }
}
