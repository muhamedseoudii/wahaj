part of 'add_business_cubit.dart';

class AddBusinessState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const AddBusinessState({
    required this.model,
    required this.status,
  });

  factory AddBusinessState.initial() {
    return AddBusinessState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  AddBusinessState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return AddBusinessState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
