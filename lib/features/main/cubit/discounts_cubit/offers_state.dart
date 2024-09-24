part of 'offers_cubit.dart';

class OffersState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const OffersState({
    required this.model,
    required this.status,
  });

  factory OffersState.initial() {
    return OffersState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  OffersState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return OffersState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
