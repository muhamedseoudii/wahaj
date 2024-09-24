class FireStoreBaseModel {
  String? _error;
  Map<String, dynamic>? _data;
  int? _code;

  FireStoreBaseModel({String? error, Map<String, dynamic>? data, int? code}) {
    _error = error;
    _data = data;
    _code = code;
  }

  String? get error => _error;

  set error(String? value) {
    _error = value;
  }

  Map<String, dynamic>? get data => _data;

  set data(Map<String, dynamic>? value) {
    _data = value;
  }

  int? get code => _code;

  set code(int? value) {
    _code = value;
  }

  @override
  String toString() {
    return 'FireStoreBaseModel{_error: $_error, _data: $_data, _code: $_code}';
  }
}
