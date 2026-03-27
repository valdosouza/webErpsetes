/// Pure validation helpers for forms and automated tests (no I/O).
/// Added for deterministic widget/unit tests; wire into Auth screens when ready.
class InputValidators {
  InputValidators._();

  static final RegExp _emailPattern = RegExp(
    r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$',
  );

  static bool isValidEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return false;
    return _emailPattern.hasMatch(trimmed);
  }

  /// Returns a user-facing error message or null if valid.
  static String? emailError(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    if (!isValidEmail(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? passwordError(String? value, {int minLength = 1}) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < minLength) {
      return 'Mínimo de $minLength caracteres';
    }
    return null;
  }
}
