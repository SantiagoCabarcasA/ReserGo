import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_places.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/category_chips.dart';
import '../widgets/place_card.dart';
import '../widgets/recommended_card.dart';
import 'search_results_screen.dart';
import '../utils/app_navigation.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, this.userName = 'Santiago'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    navigateToTab(context, index, currentIndex: _currentIndex);
  }

  Future<void> _openSearch() async {
    FocusScope.of(context).unfocus();

    final query = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          initialQuery: _searchController.text.trim(),
        ),
      ),
    );

    // Si el usuario editó la búsqueda, se refleja en el campo del Inicio.
    if (!mounted || query == null) return;
    _searchController.text = query;
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.userName;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Scaffold(
      bottomNavigationBar: ReserGoBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Saludo + avatar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, $name 👋',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Descubre y reserva hoy',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              color: AppColors.label,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        initial,
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // Buscador: abre la pantalla de resultados
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _SearchField(
                  controller: _searchController,
                  onTap: _openSearch,
                ),
              ),
              const SizedBox(height: 24),

              // Categorías
              CategoryChips(categories: homeCategories),
              const SizedBox(height: 28),

              // Disponibles ahora
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Disponibles ahora',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Ver todos',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 240,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: availableNowPlaces.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, i) => Align(
                    alignment: Alignment.topLeft,
                    child: PlaceCard(place: availableNowPlaces[i]),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Recomendados para ti
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Recomendados para ti',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    for (final place in recommendedPlaces) ...[
                      RecommendedCard(place: place),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const _SearchField({required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(26),
      borderSide: const BorderSide(color: AppColors.border, width: 1),
    );

    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        readOnly: true,
        showCursor: false,
        enableInteractiveSelection: false,
        onTap: onTap,
        style: GoogleFonts.outfit(fontSize: 16, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Buscar restaurantes, hoteles, spas...',
          hintStyle: GoogleFonts.outfit(fontSize: 16, color: AppColors.hint),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.primary, size: 26),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}