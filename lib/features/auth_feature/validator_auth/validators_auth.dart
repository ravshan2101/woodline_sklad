abstract class Validators {
  static String? empty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }

    return null;
  }

  static String? userName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }

    return null;
  }

  static String? passwordString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }
    return null;
  }

  static String? id(String? value) {
    if (value!.isEmpty) {
      return 'Не должно быть пустым';
    } else if (value.length < 6) {
      return "Ид номер содержит менее 6 цифр";
    }
    return null;
  }
}
