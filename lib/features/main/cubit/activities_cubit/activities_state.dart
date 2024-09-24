part of 'activities_cubit.dart';

class ActivitiesState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const ActivitiesState({
    required this.model,
    required this.status,
  });

  factory ActivitiesState.initial() {
    return ActivitiesState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  ActivitiesState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return ActivitiesState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
