import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';

import '../../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../../core/resource/cubit_status.dart';
import '../../../../../core/storage/shared_pref/shared_preferences.dart';

part 'sign_state.dart';

class SignUpCubit extends Cubit<SignState> {
  SignUpCubit() : super(SignState.initial());

  void signUp({required Map<String, dynamic> body}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel model = await FireStoreAddMethod.signUp(body: body);

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(model.code)) {
      AppSharedPreferences.setLogin(isLogin: true);
      AppSharedPreferences.setUserName(userName: body['email']);
      emit(state.copyWith(status: CubitStatus.success, model: model));
    } else {
      emit(state.copyWith(status: CubitStatus.error,model: model));
    }
  }
}
