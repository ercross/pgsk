///Validators contain static functions to validate TextFormField input
class Validators {
  Validators._();

  static String validateEmail(String input) {
    if (input.contains("\@")) return null;
    return "Please enter a valid email";
  }

  static String validatePhoneNumber(String input) {
    if (input.startsWith('\+')) {
      String modfied = input.substring(1);
      if (int.tryParse(modfied) == null) return null;
      return "Please enter a valid phone number";
    } else if (int.tryParse(input) == null) return null;
    return "Please enter a valid phone number";
  }

  static String validateText(String input, String label) {
    if (input.isEmpty) return "Please enter a valid $label";
    return null;
  }
}
