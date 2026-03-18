import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../widgets/skeleton.dart';
import '../widgets/gradient_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<dynamic> _testimonials = [];
  bool _loading = true;
  late AnimationController _controller;
  late Animation<int> _count300, _count100;
  late Animation<double> _count49;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _count300 = IntTween(begin: 0, end: 300).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _count100 = IntTween(begin: 0, end: 100).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _count49  = Tween<double>(begin: 0, end: 4.9).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final t = await ApiService.getTestimonials();
      setState(() { _testimonials = t.take(3).toList(); _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF080B12).withOpacity(0.95),
        title: RichText(text: const TextSpan(children: [
          TextSpan(text: 'Team', style: TextStyle(color: Color(0xFF4ADE80), fontWeight: FontWeight.w800, fontSize: 22)),
          TextSpan(text: 'NAK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
        ])),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser, color: Color(0xFF4ADE80)),
            onPressed: () => launchUrl(Uri.parse('https://theteamnak.com')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [const Color(0xFF4ADE80).withOpacity(0.08), Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ADE80).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0xFF4ADE80).withOpacity(0.3)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      const Text('Available for new projects', style: TextStyle(color: Color(0xFF4ADE80), fontSize: 12, fontWeight: FontWeight.w500)),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  const Text('Bots.\nBlockchain.\nBrilliance.', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w800, height: 1.15)),
                  const SizedBox(height: 16),
                  Text(
                    'We create the future with smart bots, blockchain solutions, and ideas that move the world closer to something great.',
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 28),
                  Row(children: [
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse('https://theteamnak.com/contact')),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF4ADE80), Color(0xFF60A5FA), Color(0xFFA855F7)]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('Start a Project', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 36),
                  // Animated Stats
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatItem(value: '${_count300.value}+', label: 'Solutions\nDelivered'),
                        _StatItem(value: '${_count100.value}%', label: 'On-Time\nDelivery'),
                        _StatItem(value: '${_count49.value.toStringAsFixed(1)}★', label: 'Client\nRating'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Testimonials
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientText('What Clients Say', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800), gradient: brandGradient),
                  const SizedBox(height: 16),
                  _loading
                      ? Column(children: List.generate(2, (_) => const Padding(padding: EdgeInsets.only(bottom: 12), child: CardSkeleton())))
                      : _testimonials.isEmpty
                          ? const Center(child: Text('No testimonials yet.', style: TextStyle(color: Colors.white38)))
                          : Column(
                              children: _testimonials.map((t) => _TestimonialCard(t: t)).toList(),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GradientText(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800), gradient: brandGradient),
      const SizedBox(height: 4),
      Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11, height: 1.4)),
    ]);
  }
}

class _TestimonialCard extends StatelessWidget {
  final dynamic t;
  const _TestimonialCard({required this.t});

  @override
  Widget build(BuildContext context) {
    final rating = (t['rating'] ?? 5).toInt();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: List.generate(5, (i) => Icon(Icons.star, size: 14, color: i < rating ? const Color(0xFFFBBF24) : Colors.white12))),
        const SizedBox(height: 10),
        Text('"${t['message'] ?? ''}"', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, fontStyle: FontStyle.italic, height: 1.5)),
        const SizedBox(height: 10),
        Text(t['name'] ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }
}
