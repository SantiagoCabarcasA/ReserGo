import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_places.dart';
import '../models/place.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/result_card.dart';
import '../utils/app_navigation.dart';

class SearchResultsScreen extends StatefulWidget {
  /// Texto escrito en el Inicio. Si está vacío se usa la búsqueda por defecto.
  final String initialQuery;

  const SearchResultsScreen({super.key, this.initialQuery = ''});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  static const _stopWords = {'en', 'de', 'del', 'el', 'la', 'los', 'las', 'y', 'a'};

  late final TextEditingController _controller;
  bool _edited = false;

  // Filtros (el de calificación empieza activo, como en el PDF)
  bool _distanceFilter = false;
  bool _ratingFilter = true;
  bool _priceFilter = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery.trim());
       
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _normalize(String s) => s
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ü', 'u');

  List<Place> get _results {
    final words = _normalize(_controller.text)
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1 && !_stopWords.contains(w))
        .toList();

    return restaurantResults.where((p) {
      if (_ratingFilter && p.rating < 4.5) return false;
      if (words.isEmpty) return true;
      final haystack = _normalize(
        '${p.name} ${p.category} ${p.cuisine ?? ''} ${p.zone ?? ''}',
      );
      return words.any((w) => haystack.contains(w));
    }).toList();
  }

  /// Regresa al Inicio. Si el usuario editó la búsqueda, devuelve el texto.
  void _close() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop(_edited ? _controller.text.trim() : null);
  }

  void _onNavTap(int index) {
    if (index == 0) {
      _close();
    } else {
    navigateToTab(context, index, currentIndex: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      bottomNavigationBar: keyboardOpen
          ? null
          : ReserGoBottomNavBar(currentIndex: 0, onTap: _onNavTap),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Flecha + campo de búsqueda
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _close,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: AppColors.textDark),
                  ),
                  const SizedBox(width: 4),
                  Expanded(child: _buildSearchField()),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Filtros
            SizedBox(
              height: 32,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  FilterChipButton(
                    label: 'Distancia',
                    showChevron: true,
                    selected: _distanceFilter,
                    onTap: () =>
                        setState(() => _distanceFilter = !_distanceFilter),
                  ),
                  const SizedBox(width: 8),
                  FilterChipButton(
                    label: 'Calificación: 4.5+',
                    selected: _ratingFilter,
                    onTap: () => setState(() => _ratingFilter = !_ratingFilter),
                  ),
                  const SizedBox(width: 8),
                  FilterChipButton(
                    label: 'Precio',
                    selected: _priceFilter,
                    onTap: () => setState(() => _priceFilter = !_priceFilter),
                  ),
                ],
              ),
            ),

            // Resultados
            Expanded(
              child: results.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (_, i) => ResultCard(place: results[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onChanged: (_) => setState(() => _edited = true),
        onSubmitted: (_) => FocusScope.of(context).unfocus(),
        style: GoogleFonts.outfit(fontSize: 16, color: AppColors.textDark),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: 'Buscar restaurantes, hoteles, spas...',
          hintStyle: GoogleFonts.outfit(fontSize: 16, color: AppColors.hint),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 44, minHeight: 44),
          suffixIcon: _controller.text.isEmpty
              ? null
              : GestureDetector(
                  onTap: () => setState(() {
                    _controller.clear();
                    _edited = true;
                  }),
                  child: const Icon(Icons.cancel,
                      size: 22, color: AppColors.icon),
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.lavender,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.search_off_rounded,
                  size: 38, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text(
              'Sin resultados',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'No encontramos lugares para tu búsqueda. Prueba con otras palabras o quita algún filtro.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontSize: 16, color: AppColors.hint),
            ),
          ],
        ),
      ),
    );
  }
}