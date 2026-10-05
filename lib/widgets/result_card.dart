import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/place.dart';
import '../theme/app_theme.dart';

class ResultCard extends StatelessWidget {
  final Place place;
  final VoidCallback? onTap;

  const ResultCard({super.key, required this.place, this.onTap});

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          '•',
          style: GoogleFonts.outfit(fontSize: 12, color: AppColors.icon),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 100,
                height: 100,
                child: place.imageAsset != null
                    ? Image.asset(place.imageAsset!, fit: BoxFit.cover)
                    : Container(
                        color: AppColors.lavender,
                        child: const Icon(Icons.restaurant_outlined,
                            color: AppColors.primary),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    place.subtitleLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      color: AppColors.label,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star_border_rounded,
                          size: 20, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        place.ratingLabel,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      _dot(),
                      Text(
                        place.distanceLabel,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          color: AppColors.label,
                        ),
                      ),
                      if (place.priceLabel.isNotEmpty) ...[
                        _dot(),
                        Text(
                          place.priceLabel,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.label,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (place.isAvailableNow) ...[
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Disponible hoy',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}