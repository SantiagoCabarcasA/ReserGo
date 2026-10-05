import 'package:flutter/material.dart';
import '../data/user_session.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

const int kHomeTab = 0;
const int kMapTab = 1;
const int kBookingsTab = 2;
const int kNotificationsTab = 3;
const int kProfileTab = 4;

/// Pantalla de cada pestaña. Devuelve null si todavía no existe.
Widget? _tabScreen(int index) {
  switch (index) {
    case kHomeTab:
      return HomeScreen(userName: UserSession.firstName);
    case kProfileTab:
      return const ProfileScreen();
    // Cuando crees las demás, descomenta la que corresponda:
    // case kMapTab:
    //   return const MapScreen();
    // case kBookingsTab:
    //   return const BookingsScreen();
    // case kNotificationsTab:
    //   return const NotificationsScreen();
    default:
      return null;
  }
}

/// Cambia de pestaña desde la barra inferior.
void navigateToTab(
  BuildContext context,
  int index, {
  required int currentIndex,
}) {
  if (index == currentIndex) return;

  final screen = _tabScreen(index);
  if (screen == null) return; // pestaña aún sin pantalla

  Navigator.of(context).pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    (route) => false,
  );
}