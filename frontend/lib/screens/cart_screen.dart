import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shashlyk_mashlyk_app/screens/checkout_screen.dart';
import 'package:shashlyk_mashlyk_app/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Consumer<CartService>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text('Ваша корзина пуста'),
            );
          }

          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final cartItem = cart.items.values.toList()[index];
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image),
                ),
                title: Text(cartItem.product.name),
                subtitle: Text('${cartItem.product.price} ₽'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cart.updateQuantity(cartItem.product.id, cartItem.quantity - 1);
                      },
                    ),
                    Text(cartItem.quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cart.updateQuantity(cartItem.product.id, cartItem.quantity + 1);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartService>(
        builder: (context, cart, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Итого: ${cart.totalPrice.toStringAsFixed(2)} ₽',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ElevatedButton(
                    onPressed: cart.items.isEmpty ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                      );
                    },
                    child: const Text('Оформить заказ'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
