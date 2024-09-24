import 'package:equatable/equatable.dart';

import '../../../../../core/firebase/firebase_core/firestore_base_model.dart';
import '../../../../../core/resource/cubit_status.dart';

class SubActivityState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SubActivityState({
    required this.model,
    required this.status,
  });

  factory SubActivityState.initial() {
    return SubActivityState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SubActivityState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SubActivityState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
