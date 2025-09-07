import 'package:shashlyk_mashlyk_app/models/category.dart';
import 'package:shashlyk_mashlyk_app/models/product.dart';

class ApiService {
  // MOCK DATA - this would be fetched from the backend API
  final List<Category> _mockCategories = [
    Category(id: 1, name: 'Шашлыки'),
    Category(id: 2, name: 'Люля-кебаб'),
    Category(id: 3, name: 'Салаты'),
    Category(id: 4, name: 'Напитки'),
  ];

  final List<Product> _mockProducts = [
    Product(id: 1, categoryId: 1, name: 'Шашлык из свинины', price: 550.0, isPopular: true, description: 'Сочный шашлык из свежей свиной шеи.'),
    Product(id: 2, categoryId: 1, name: 'Шашлык из курицы', price: 450.0, description: 'Нежный шашлык из куриного филе.'),
    Product(id: 3, categoryId: 1, name: 'Шашлык из баранины', price: 650.0, isPopular: true, description: 'Ароматный шашлык из мякоти баранины.'),
    Product(id: 4, categoryId: 2, name: 'Люля-кебаб из говядины', price: 480.0, isPopular: true, description: 'Классический люля-кебаб.'),
    Product(id: 5, categoryId: 2, name: 'Люля-кебаб из курицы', price: 420.0, description: 'Диетический люля-кебаб.'),
    Product(id: 6, categoryId: 3, name: 'Салат "Греческий"', price: 250.0, description: 'Свежие овощи с сыром фета.'),
    Product(id: 7, categoryId: 3, name: 'Салат "Цезарь"', price: 350.0, description: 'Классический салат с курицей.'),
    Product(id: 8, categoryId: 4, name: 'Морс клюквенный', price: 100.0, description: 'Освежающий домашний морс.'),
  ];

  // Simulates fetching categories from the API
  Future<List<Category>> getCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockCategories;
  }

  // Simulates fetching products, optionally by category
  Future<List<Product>> getProducts({int? categoryId}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (categoryId != null) {
      return _mockProducts.where((p) => p.categoryId == categoryId).toList();
    }
    return _mockProducts;
  }

  // Simulates fetching popular products
  Future<List<Product>> getPopularProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockProducts.where((p) => p.isPopular).toList();
  }
}
