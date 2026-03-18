import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../widgets/skeleton.dart';
import '../widgets/gradient_text.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});
  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<dynamic> _blogs = [];
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final data = await ApiService.getBlogs();
      setState(() { _blogs = data; _loading = false; });
    } catch (_) { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        title: const GradientText('Blog', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), gradient: brandGradient),
      ),
      body: _loading
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(padding: EdgeInsets.only(bottom: 12), child: CardSkeleton()),
            )
          : _blogs.isEmpty
              ? const Center(child: Text('No blogs available.', style: TextStyle(color: Colors.white38)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _blogs.length,
                  itemBuilder: (_, i) => _BlogCard(blog: _blogs[i]),
                ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final dynamic blog;
  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    final imageUrl = blog['image'] ?? '';
    final id = blog['_id'];
    return GestureDetector(
      onTap: () { if (id != null) launchUrl(Uri.parse('https://theteamnak.com/blog/$id')); },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: CachedNetworkImage(imageUrl: imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover,
                    placeholder: (_, __) => Container(height: 180, color: Colors.white.withOpacity(0.05)),
                    errorWidget: (_, __, ___) => const SizedBox.shrink()),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(blog['title'] ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 8),
                Text(blog['summary'] ?? blog['content'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13, height: 1.5)),
                const SizedBox(height: 12),
                Row(children: [
                  const Text('Read More', style: TextStyle(color: Color(0xFFA855F7), fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 13, color: Color(0xFFA855F7)),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
