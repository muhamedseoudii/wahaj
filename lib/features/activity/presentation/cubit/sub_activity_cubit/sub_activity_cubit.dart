import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../../core/resource/cubit_status.dart';
import 'sub_activity_state.dart';

class SubActivityCubit extends Cubit<SubActivityState> {
  SubActivityCubit() : super(SubActivityState.initial());

  void getSubActivities({required String activityCollectionName}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreGetMethod.getSubActivity(
        activityCollectionName: activityCollectionName);

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error, model: model));
    }
  }
}
