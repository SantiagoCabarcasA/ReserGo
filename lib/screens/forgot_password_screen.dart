import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

enum _ForgotStatus { initial, loading, success }

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  _ForgotStatus _status = _ForgotStatus.initial;
  String? _errorText;

  static final _emailRegex =
      RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[\w\-]{2,}$');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_status == _ForgotStatus.loading) return;

    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() => _errorText = 'Ingresa tu correo electrónico');
      return;
    }
    if (!_emailRegex.hasMatch(email)) {
      setState(() => _errorText = 'Ingresa un correo electrónico válido');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _errorText = null;
      _status = _ForgotStatus.loading;
    });

    // Simulación de envío (sin backend real).
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() => _status = _ForgotStatus.success);
  }

  void _backToLogin() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final isSuccess = _status == _ForgotStatus.success;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: isSuccess ? _buildSuccess() : _buildForm(),
                ),
              ),
              if (!isSuccess)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, top: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '¿Recordaste tu contraseña? ',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: AppColors.label,
                        ),
                      ),
                      GestureDetector(
                        onTap: _backToLogin,
                        child: Text(
                          'Volver a iniciar sesión',
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

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          '¿Olvidaste tu contraseña?',
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'No te preocupes. Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: AppColors.hint,
          ),
        ),
        const SizedBox(height: 28),
        CustomTextField(
          label: 'Correo electrónico',
          hint: 'Correo electrónico',
          icon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: _errorText,
          onChanged: (_) {
            if (_errorText != null) setState(() => _errorText = null);
          },
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Enviar enlace',
          isLoading: _status == _ForgotStatus.loading,
          onPressed: _submit,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSuccess() {
    return Column(
      children: [
        const SizedBox(height: 80),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.lavender,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 38,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          '¡Enlace enviado!',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Si el correo está registrado, recibirás instrucciones para restablecer tu contraseña.',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: AppColors.hint,
          ),
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          text: 'Volver a iniciar sesión',
          onPressed: _backToLogin,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}