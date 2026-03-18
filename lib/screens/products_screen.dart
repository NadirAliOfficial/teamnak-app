import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../widgets/skeleton.dart';
import '../widgets/gradient_text.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<dynamic> _products = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getProducts();
      setState(() { _products = data; _loading = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        title: const GradientText('Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), gradient: brandGradient),
      ),
      body: _loading
          ? GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: 6,
              itemBuilder: (_, __) => const CardSkeleton(),
            )
          : _error != null
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(_error!, style: const TextStyle(color: Colors.redAccent)),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: () { setState(() { _loading = true; _error = null; }); _load(); }, child: const Text('Retry')),
                ]))
              : _products.isEmpty
                  ? const Center(child: Text('No products found.', style: TextStyle(color: Colors.white38)))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.78, crossAxisSpacing: 12, mainAxisSpacing: 12),
                      itemCount: _products.length,
                      itemBuilder: (_, i) => _ProductCard(product: _products[i]),
                    ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product['image'] ?? '';
    return GestureDetector(
      onTap: () {
        final id = product['_id'];
        if (id != null) launchUrl(Uri.parse('https://theteamnak.com/product/$id'));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(imageUrl: imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover,
                      placeholder: (_, __) => Container(height: 100, color: Colors.white.withOpacity(0.05)),
                      errorWidget: (_, __, ___) => Container(height: 100, color: Colors.white.withOpacity(0.05), child: const Icon(Icons.image_not_supported, color: Colors.white24)))
                  : Container(height: 100, color: Colors.white.withOpacity(0.05), child: const Icon(Icons.inventory_2, color: Colors.white24)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(product['title'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text(product['category'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
