class Place {
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final String? imageAsset;
  final bool isAvailableNow;
  final String? cuisine;
  final String? zone;
  final int priceLevel;

  const Place({
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    this.imageAsset,
    this.isAvailableNow = false,
    this.cuisine,
    this.zone,
    this.priceLevel = 0,
  });

  String get ratingLabel => rating.toStringAsFixed(1);
  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
  String get priceLabel => priceLevel > 0 ? '\$' * priceLevel : '';
  String get subtitleLabel => [cuisine, zone].whereType<String>().join(' • ');
}