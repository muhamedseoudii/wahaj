import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import 'package:mo_wahaj_top/core/helper/validtor_helper.dart';

import '../../../../core/firebase/firebase_core/firestore_status_code.dart';
import '../../../../core/resource/cubit_status.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  void search({required String searchKey}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    FireStoreBaseModel placesModel = await FireStoreGetMethod.search();

    if (isClosed) return;

    if (FireStoreStatusCode.successStatus().contains(placesModel.code)) {
      List<Map<String, dynamic>> places =
      (placesModel.data?['places'] ?? []).cast<Map<String, dynamic>>();

      placesModel.data?['places'] = places.where((element) {
        if (searchKey.isEnglishWord() == true) {
          return ((element['en_name'] ?? "") as String).contains(searchKey);
        } else {
          return ((element['ar_name'] ?? "") as String).contains(searchKey);
        }
      }).toList();
      emit(state.copyWith(status: CubitStatus.success, model: placesModel));
    } else {
      emit(state.copyWith(status: CubitStatus.error, model: placesModel));
    }
  }
}
