import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';

import '../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../core/resource/cubit_status.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesState.initial());

  void getPlaces() async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreGetMethod.getPlaces();

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error,model: model));
    }
  }
}
