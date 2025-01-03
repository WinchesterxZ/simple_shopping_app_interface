import 'package:flutter/material.dart';
import 'package:shopping_app_interface/features/shopping_screen/widgets/product_item.dart';
// This class represents the home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Create the state for the home page
}

// This class represents the state of the home page widget
class _MyHomePageState extends State<MyHomePage> {
  // List of product images
  final List<String> _productImages = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/301',
    'https://picsum.photos/200/302',
    'https://picsum.photos/200/303',
  ];

  // List of hot offer images
  final List<String> _hotOfferImages = [
    'https://picsum.photos/200/303',
    'https://picsum.photos/200/304',
    'https://picsum.photos/200/305',
    'https://picsum.photos/200/306',
    'https://picsum.photos/200/307',
  ];

  // List of product names
  final List<String> _productNames = [
    'Nike Air Max 270',
    'Samsung Galaxy S23',
    'Apple AirPods Pro',
    'Sony WH-1000XM4',
  ];

  // List of hot offer names
  final List<String> _hotOfferNames = [
    '50% OFF - Adidas Ultra Boost',
    'Flash Sale - iPhone 14 Pro',
    'Bundle Deal - PS5 + 2 Games',
    'Limited Time - iPad Air 2023',
    'Special Offer - MacBook Air',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Shopping App'), // Title of the app bar
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the products section
              const Text(
                'Our Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Product images carousel
              SizedBox(
                // Found this height ratio by accident, but it looks perfect on most phones
                height: screenSize.height * 0.25, // Set height
                child: PageView.builder(
                  itemCount: _productImages.length, // Number of items
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      child: Image.network(
                        _productImages[index], // Display product image
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Product grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  childAspectRatio: 0.8,  // Tried 0.7 and 0.9, this one's just right
                  mainAxisSpacing: 8.0, // Spacing between items
                  crossAxisSpacing: 8.0, // Spacing between columns
                ),
                itemCount: _productImages.length, // Number of items
                itemBuilder: (context, index) {
                  return ProductItem(
                    productImage: _productImages[index], // Product image
                    productName: _productNames[index], // Product name
                  );
                },
              ),
              const SizedBox(height: 16),
              // Title of the hot offers section
              const Text(
                'Hot Offers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Hot offers list
              SizedBox(
                height: screenSize.height * 0.25, // Set a fixed height to control scrolling area
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  itemCount: _hotOfferNames.length, // Number of items
                  itemBuilder: (context, index) {
                    return SizedBox(
                      // Hot offers need different width on tablets, might need to adjust this later
                      width: screenSize.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ProductItem(
                          productImage: _hotOfferImages[index], // Hot offer image
                          productName: _hotOfferNames[index], // Hot offer name
                          showCartIcon: false, // Disable cart icon for offers
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


