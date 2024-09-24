part of 'privacy_policy_cubit.dart';

class PrivacyPolicyState extends Equatable {
  final FireStoreBaseModel model;
  final CubitStatus status;

  const PrivacyPolicyState({
    required this.model,
    required this.status,
  });

  factory PrivacyPolicyState.initial() {
    return PrivacyPolicyState(
        model: FireStoreBaseModel(), status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  PrivacyPolicyState copyWith(
      {String? error, FireStoreBaseModel? model, CubitStatus? status}) {
    return PrivacyPolicyState(
      model: model ?? this.model,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [ status, model];
  }
}
