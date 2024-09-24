part of 'search_cubit.dart';

class SearchState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const SearchState({
    required this.model,
    required this.status,
  });

  factory SearchState.initial() {
    return SearchState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  SearchState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return SearchState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
