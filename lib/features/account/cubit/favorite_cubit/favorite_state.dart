part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const FavoriteState({
    required this.model,
    required this.status,
  });

  factory FavoriteState.initial() {
    return FavoriteState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  FavoriteState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return FavoriteState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
