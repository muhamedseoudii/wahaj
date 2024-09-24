part of 'home_cubit.dart';

class HomeState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const HomeState({
    required this.model,
    required this.status,
  });

  factory HomeState.initial() {
    return HomeState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  HomeState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return HomeState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
