class TourPackage {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;

  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

const List<TourPackage> tourPackages = [
  TourPackage(
    id: 'TR001',
    title: 'Pantai Pangandaran',
    description: 'Nikmati pantai indah dan pemandangan matahari terbenam.',
    price: 350000,
    imageUrl:
        'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?w=900',
  ),
  TourPackage(
    id: 'TR002',
    title: 'Kawah Putih',
    description: 'Wisata danau kawah dengan pemandangan yang menakjubkan.',
    price: 275000,
    imageUrl:
        'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=900',
  ),
  TourPackage(
    id: 'TR003',
    title: 'Gunung Bromo',
    description: 'Nikmati keindahan pegunungan dan matahari terbit.',
    price: 650000,
    imageUrl:
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=900',
  ),
  TourPackage(
    id: 'TR004',
    title: 'Ubud Bali',
    description: 'Jelajahi keindahan alam dan budaya Bali.',
    price: 850000,
    imageUrl:
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=900',
  ),
];
