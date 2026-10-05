import '../models/place.dart';

const availableNowPlaces = [
  Place(
    name: 'La Boqueria Bistró',
    category: 'Restaurantes',
    rating: 4.9,
    distanceKm: 0.8,
    imageAsset: 'assets/images/restaurant.jpg',
    isAvailableNow: true,
  ),
  Place(
    name: 'Hotel Loft Sky',
    category: 'Hoteles',
    rating: 4.7,
    distanceKm: 1.4,
    imageAsset: 'assets/images/hotel.jpg',
    isAvailableNow: true,
  ),
  Place(
    name: 'Nest Cowork',
    category: 'Coworking',
    rating: 4.6,
    distanceKm: 2.0,
    isAvailableNow: true,
  ),
];

const recommendedPlaces = [
  Place(
    name: 'Savia Zen Spa',
    category: 'Spa & Wellness',
    rating: 4.8,
    distanceKm: 1.1,
    imageAsset: 'assets/images/spa.jpg',
  ),
];

const homeCategories = ['Restaurantes', 'Hoteles', 'Eventos', 'Spa'];


const restaurantResults = [
  Place(
    name: 'La Boqueria Bistró',
    category: 'Restaurantes',
    cuisine: 'Comida Mediterránea',
    zone: 'Plaza Mayor',
    rating: 4.9,
    distanceKm: 0.8,
    priceLevel: 3,
    imageAsset: 'assets/images/result_boqueria.jpg',
    isAvailableNow: true,
  ),
  Place(
    name: 'Bistró Real Centro',
    category: 'Restaurantes',
    cuisine: 'Cocina de Autor',
    zone: 'Gran Vía',
    rating: 4.8,
    distanceKm: 1.2,
    priceLevel: 2,
    imageAsset: 'assets/images/result_bistro.jpg',
    isAvailableNow: true,
  ),
  Place(
    name: 'El Rinconcito Gourmet',
    category: 'Restaurantes',
    cuisine: 'Tapas & Vinos',
    zone: 'Barrio Viejo',
    rating: 4.5,
    distanceKm: 2.1,
    priceLevel: 2,
    imageAsset: 'assets/images/result_rinconcito.jpg',
    isAvailableNow: true,
  ),
];