import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/user_session.dart';
import '../theme/app_theme.dart';
import '../utils/app_navigation.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/profile_menu_tile.dart';
import 'login_screen.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Cerrar sesión',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: GoogleFonts.outfit(fontSize: 16, color: AppColors.label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.label,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Salir',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    UserSession.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = UserSession.displayName;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Scaffold(
      bottomNavigationBar: ReserGoBottomNavBar(
        currentIndex: kProfileTab,
        onTap: (i) => navigateToTab(context, i, currentIndex: kProfileTab),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Avatar
              Container(
                width: 88,
                height: 88,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  initial,
                  style: GoogleFonts.outfit(
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nombre y correo
              Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                UserSession.email,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: AppColors.label,
                ),
              ),
              const SizedBox(height: 24),

              // Opciones (aún sin pantalla propia, salvo Cerrar sesión)
              const ProfileMenuTile(
                icon: Icons.person_outline_rounded,
                label: 'Información personal',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.credit_card_outlined,
                label: 'Métodos de pago',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.history_rounded,
                label: 'Historial de pagos',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.favorite_border_rounded,
                label: 'Lugares favoritos',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.tune_rounded,
                label: 'Preferencias',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.language_rounded,
                label: 'Idioma',
              ),
              const SizedBox(height: 10),
              const ProfileMenuTile(
                icon: Icons.help_outline_rounded,
                label: 'Ayuda y soporte',
              ),
              const SizedBox(height: 10),
              ProfileMenuTile(
                icon: Icons.logout_rounded,
                label: 'Cerrar sesión',
                color: AppColors.danger,
                onTap: () => _confirmLogout(context),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}