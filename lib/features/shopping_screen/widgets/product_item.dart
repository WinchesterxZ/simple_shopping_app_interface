import 'package:flutter/material.dart';

// Had to make this widget reusable
// Shows a product card with image, name and add-to-cart button
class ProductItem extends StatelessWidget {
  final String productImage;
  final String productName;
  final bool showCartIcon; // New parameter

  const ProductItem({
    super.key,
    required this.productImage,
    required this.productName,
    this.showCartIcon = true, // Default to true for backward compatibility
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Gives that nice floating effect
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Wrapped image in Expanded to stop layout issues on small screens
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounds the image corners
                child: Image.network(
                  productImage,
                  fit: BoxFit.cover, // Makes sure image fills space nicely
                ),
              ),
            ),
            // Quick spacing hack between image and text
            const SizedBox(height: 8),
            // Product name - keeping it simple with basic styling
            Text(
              productName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            // Shopping cart button with feedback snackbar
            if (showCartIcon) // Only show cart icon if showCartIcon is true
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item added to cart'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
