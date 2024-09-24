import 'package:equatable/equatable.dart';

import '../../../../../core/firebase/firebase_core/firestore_base_model.dart';
import '../../../../../core/resource/cubit_status.dart';

class SubActivityAdsState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SubActivityAdsState({
    required this.model,
    required this.status,
  });

  factory SubActivityAdsState.initial() {
    return SubActivityAdsState(
        model: FireStoreBaseModel(),   status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SubActivityAdsState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SubActivityAdsState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
