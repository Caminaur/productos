class PasswordValidator {
  static validatePassword({
    required String? pass,
  }) {
    List errores = [];
    if (pass == null || pass.isEmpty) {
      return false;
    }

    bool hasUppercase = pass.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = pass.contains(RegExp(r'[a-z]'));
    bool hasDigits = pass.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters =
        pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = pass.length >= 8;

    if (!hasDigits) {
      errores.add('La contraseña requiero por lo menos un número.');
    }
    if (!hasLowercase || !hasUppercase) {
      errores.add(
          'La contraseña requiero por lo menos una mayúscula y una minúscula.');
    }
    if (!hasSpecialCharacters) {
      errores.add('La contraseña requiere por lo menos un caracter especial.');
    }
    if (!hasMinLength) {
      errores.add('La contraseña debe tener por lo menos 8 caracteres.');
    }

    return errores;
  }
}
