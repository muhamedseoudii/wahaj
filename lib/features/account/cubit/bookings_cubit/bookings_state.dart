part of 'bookings_cubit.dart';

class BookingsState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const BookingsState({
    required this.model,
    required this.status,
  });

  factory BookingsState.initial() {
    return BookingsState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  BookingsState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return BookingsState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
