extension ValidtorHelper on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return RegExp(r'^[\+\d\u0660-\u0669][\d\u0660-\u0669\s\-\(\)]{7,}$')
        .hasMatch(this);
  }

  bool isArabicWords() {
    return RegExp(r'\b[\u0621-\u064A]+\b').hasMatch(this);
  }

  bool isEnglishWord(){
    return  RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
}
