import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/user_session.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptedTerms = true;

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _termsError;

  static final _emailRegex =
      RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[\w\-]{2,}$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    final nameError = name.isEmpty ? 'Ingresa tu nombre completo' : null;

    String? emailError;
    if (email.isEmpty) {
      emailError = 'Ingresa tu correo electrónico';
    } else if (!_emailRegex.hasMatch(email)) {
      emailError = 'Ingresa un correo electrónico válido';
    }

    final phoneError = phone.isEmpty ? 'Ingresa tu número de teléfono' : null;

    String? passwordError;
    if (password.isEmpty) {
      passwordError = 'Ingresa una contraseña';
    } else if (password.length < 6) {
      passwordError = 'Debe tener al menos 6 caracteres';
    }

    final termsError =
        _acceptedTerms ? null : 'Debes aceptar los términos y condiciones';

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _phoneError = phoneError;
      _passwordError = passwordError;
      _termsError = termsError;
    });

    if ([nameError, emailError, phoneError, passwordError, termsError]
        .any((e) => e != null)) {
      return;
    }

    FocusScope.of(context).unfocus();
    UserSession.register(name: name, email: email, phone: phone);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Cuenta creada. Ahora inicia sesión.',
            style: GoogleFonts.outfit(),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.textDark,
          duration: const Duration(seconds: 3),
        ),
      );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Crear cuenta',
                        style: GoogleFonts.outfit(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Regístrate para reservar los mejores lugares',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: AppColors.hint,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Nombre completo',
                        hint: 'Tu nombre completo',
                        icon: Icons.person_outline_rounded,
                        controller: _nameController,
                        errorText: _nameError,
                        onChanged: (_) {
                          if (_nameError != null) {
                            setState(() => _nameError = null);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Correo electrónico',
                        hint: 'correo@ejemplo.com',
                        icon: Icons.mail_outline_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
                        onChanged: (_) {
                          if (_emailError != null) {
                            setState(() => _emailError = null);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Número de teléfono',
                        hint: '+57 300 0000000',
                        icon: Icons.phone_outlined,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        errorText: _phoneError,
                        onChanged: (_) {
                          if (_phoneError != null) {
                            setState(() => _phoneError = null);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Contraseña',
                        hint: 'Crea una contraseña',
                        icon: Icons.lock_outline_rounded,
                        controller: _passwordController,
                        isPassword: true,
                        errorText: _passwordError,
                        onChanged: (_) {
                          if (_passwordError != null) {
                            setState(() => _passwordError = null);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              _acceptedTerms = !_acceptedTerms;
                              _termsError = null;
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: _acceptedTerms
                                    ? AppColors.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _acceptedTerms
                                      ? AppColors.primary
                                      : AppColors.icon,
                                  width: 1.5,
                                ),
                              ),
                              child: _acceptedTerms
                                  ? const Icon(Icons.check_circle_outline,
                                      size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text.rich(
                              TextSpan(
                                text: 'Acepto los ',
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  color: AppColors.label,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Términos y Condiciones',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_termsError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            _termsError!,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      PrimaryButton(text: 'Crear cuenta', onPressed: _register),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta? ',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: AppColors.label,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Ya tengo cuenta',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}