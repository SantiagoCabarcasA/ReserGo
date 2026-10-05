class UserSession {
  // Sesión activa (la que ve el Perfil)
  static String email = '';
  static String displayName = '';

  // Cuenta registrada en "Crear cuenta"
  static String? _registeredEmail;
  static String? _registeredName;
  static String registeredPhone = '';

  static String get firstName => displayName.split(' ').first;

  /// Se llama desde "Crear cuenta".
  static void register({
    required String name,
    required String email,
    String phone = '',
  }) {
    _registeredName = name.trim();
    _registeredEmail = email.trim().toLowerCase();
    registeredPhone = phone.trim();
  }

  /// Se llama desde "Iniciar sesión".
  static void signIn(String userEmail) {
    final typed = userEmail.trim();
    email = typed;

    if (_registeredEmail != null &&
        typed.toLowerCase() == _registeredEmail &&
        (_registeredName ?? '').isNotEmpty) {
      displayName = _registeredName!;
    } else {
      displayName = _nameFromEmail(typed);
    }
  }

  static void signOut() {
    email = '';
    displayName = '';
  }

  static String _nameFromEmail(String email) {
    final parts = email
        .split('@')
        .first
        .split(RegExp(r'[._\-+]'))
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return 'Usuario';
    return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join(' ');
  }
}