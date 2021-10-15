import 'package:smart_select/smart_select.dart' show S2Choice;

List<S2Choice<String>> sort = [
  S2Choice<String>(value: 'popular', title: 'Popular'),
  S2Choice<String>(value: 'review', title: 'Most Reviews'),
  S2Choice<String>(value: 'latest', title: 'Newest'),
  S2Choice<String>(value: 'cheaper', title: 'Low Price'),
  S2Choice<String>(value: 'pricey', title: 'High Price'),
];

List<Map<String, dynamic>> genre = [
  {
    'title': 'Plane',
    'image': 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef',
  },
  {
    'title': 'Train',
    'image': 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef',
  },
  {
    'title': 'Bus',
    'image': 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef',
  },
  {
    'title': 'Car',
    'image': 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef',
  },
  {
    'title': 'Bike',
    'image': 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef',
  },
];

List<S2Choice<String>> price = [
  S2Choice<String>(value: '50-100', title: 'Rs 50-100'),
  S2Choice<String>(value: '100-200', title: 'Rs 100-200'),
  S2Choice<String>(value: '200-300', title: 'Rs 200-300'),
  S2Choice<String>(value: '300-400', title: 'Rs 300-400'),
  S2Choice<String>(value: '400-500', title: 'Rs 400-500'),
  S2Choice<String>(value: '500-1000', title: 'Rs 500-1000'),
];

List<S2Choice<String>> ratings = [
  S2Choice<String>(value: '1', title: '1 star'),
  S2Choice<String>(value: '2', title: '2 star'),
  S2Choice<String>(value: '3', title: '3 star'),
  S2Choice<String>(value: '4', title: '4 star'),
  S2Choice<String>(value: '5', title: '5 star'),
];

List<S2Choice<String>> gesfsfnre = [
  S2Choice<String>(value: '500-100', title: 'Adventure'),
  S2Choice<String>(value: '100-200', title: 'Comedy'),
  S2Choice<String>(value: '200-300', title: 'Action'),
  S2Choice<String>(value: '300-400', title: 'Fiction'),
  S2Choice<String>(value: '400-500', title: 'Drama'),
  S2Choice<String>(value: '500-100', title: 'Thriller'),
];