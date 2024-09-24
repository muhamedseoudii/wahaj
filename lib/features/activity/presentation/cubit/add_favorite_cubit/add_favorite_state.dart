import 'package:equatable/equatable.dart';

import '../../../../../core/firebase/firebase_core/firestore_base_model.dart';
import '../../../../../core/resource/cubit_status.dart';

class AddFavoriteState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const AddFavoriteState({
    required this.model,
    required this.status,
  });

  factory AddFavoriteState.initial() {
    return AddFavoriteState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  AddFavoriteState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return AddFavoriteState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
