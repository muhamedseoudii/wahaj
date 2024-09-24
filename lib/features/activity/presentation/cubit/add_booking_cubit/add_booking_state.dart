import 'package:equatable/equatable.dart';

import '../../../../../core/firebase/firebase_core/firestore_base_model.dart';
import '../../../../../core/resource/cubit_status.dart';

class AddBookingState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const AddBookingState({
    required this.model,
    required this.status,
  });

  factory AddBookingState.initial() {
    return AddBookingState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  AddBookingState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return AddBookingState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
