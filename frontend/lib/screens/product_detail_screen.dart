import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shashlyk_mashlyk_app/models/product.dart';
import 'package:shashlyk_mashlyk_app/services/cart_service.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Product Image
            Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),

            // 2. Product Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${product.price} ₽',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F), // AppColors.primary
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    product.description ?? 'Описание отсутствует.',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. Add to Cart Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              final cart = Provider.of<CartService>(context, listen: false);
              cart.addItem(product);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} добавлен в корзину!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Добавить в корзину'),
          ),
        ),
      ),
    );
  }
}
