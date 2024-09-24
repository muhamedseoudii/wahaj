part of 'places_cubit.dart';

class PlacesState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const PlacesState({
    required this.model,
    required this.status,
  });

  factory PlacesState.initial() {
    return PlacesState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  PlacesState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return PlacesState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
