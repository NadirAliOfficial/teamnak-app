import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../widgets/skeleton.dart';
import '../widgets/gradient_text.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<dynamic> _services = [];
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final data = await ApiService.getServices();
      setState(() { _services = data; _loading = false; });
    } catch (_) { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        title: const GradientText('Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), gradient: brandGradient),
      ),
      body: _loading
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(padding: EdgeInsets.only(bottom: 12), child: CardSkeleton()),
            )
          : _services.isEmpty
              ? const Center(child: Text('No services found.', style: TextStyle(color: Colors.white38)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _services.length,
                  itemBuilder: (_, i) => _ServiceCard(service: _services[i]),
                ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final dynamic service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final imageUrl = service['img'] ?? '';
    final id = service['_id'];
    return GestureDetector(
      onTap: () { if (id != null) launchUrl(Uri.parse('https://theteamnak.com/services/$id')); },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(imageUrl: imageUrl, width: 100, height: 90, fit: BoxFit.cover,
                      placeholder: (_, __) => Container(width: 100, height: 90, color: Colors.white.withOpacity(0.05)),
                      errorWidget: (_, __, ___) => Container(width: 100, height: 90, color: Colors.white.withOpacity(0.05), child: const Icon(Icons.build, color: Colors.white24)))
                  : Container(width: 100, height: 90, color: Colors.white.withOpacity(0.05), child: const Icon(Icons.miscellaneous_services, color: Color(0xFF60A5FA))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(service['title'] ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Text('Read More', style: TextStyle(color: Color(0xFF60A5FA), fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 12, color: Color(0xFF60A5FA)),
                  ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
