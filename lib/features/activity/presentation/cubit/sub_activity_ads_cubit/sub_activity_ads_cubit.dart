import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../../core/resource/cubit_status.dart';
import 'sub_activity_ads_state.dart';

class SubActivityAdsCubit extends Cubit<SubActivityAdsState> {
  SubActivityAdsCubit() : super(SubActivityAdsState.initial());

  void getSubActivityAds({required String activityAdsCollectionName}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreGetMethod.getSubActivityAds(
        activityCollectionName: activityAdsCollectionName);

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error, model: model));
    }
  }
}
