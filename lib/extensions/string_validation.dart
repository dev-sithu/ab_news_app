extension StringValidation on String {
  bool get isValidEmail {
    final regExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(this);
  }

  bool get isValidUsername {
    final regExp = RegExp(r"^[a-zA-Z0-9._\-]+$");
    return regExp.hasMatch(this);
  }
}
