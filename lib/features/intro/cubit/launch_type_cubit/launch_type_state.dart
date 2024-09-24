part of 'launch_type_cubit.dart';

class LaunchTypeState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const LaunchTypeState({
    required this.model,
    required this.status,
  });

  factory LaunchTypeState.initial() {
    return LaunchTypeState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  LaunchTypeState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return LaunchTypeState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
