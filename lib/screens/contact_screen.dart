import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/gradient_text.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  void _launch(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        title: const GradientText('Contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800), gradient: brandGradient),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text("Let's Build Something", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
            const GradientText('Great Together', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800), gradient: brandGradient),
            const SizedBox(height: 12),
            Text('Have a project idea? We\'d love to hear from you.', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14, height: 1.6)),
            const SizedBox(height: 32),

            _ContactButton(
              icon: Icons.language,
              label: 'Visit Website',
              subtitle: 'theteamnak.com',
              color: const Color(0xFF4ADE80),
              onTap: () => _launch('https://theteamnak.com/contact'),
            ),
            const SizedBox(height: 12),
            _ContactButton(
              icon: Icons.telegram,
              label: 'Telegram',
              subtitle: '@NAKBlockDev',
              color: const Color(0xFF60A5FA),
              onTap: () => _launch('https://t.me/NAKBlockDev'),
            ),
            const SizedBox(height: 12),
            _ContactButton(
              icon: Icons.link,
              label: 'LinkedIn',
              subtitle: 'Nadir Ali Khan',
              color: const Color(0xFF60A5FA),
              onTap: () => _launch('https://www.linkedin.com/in/teamnadiralikhan'),
            ),
            const SizedBox(height: 12),
            _ContactButton(
              icon: Icons.code,
              label: 'GitHub',
              subtitle: 'NadirAliOfficial',
              color: Colors.white70,
              onTap: () => _launch('https://github.com/NadirAliOfficial'),
            ),
            const SizedBox(height: 12),
            _ContactButton(
              icon: Icons.shopping_bag_outlined,
              label: 'Fiverr',
              subtitle: 'nadiralikhan786',
              color: const Color(0xFF4ADE80),
              onTap: () => _launch('https://www.fiverr.com/nadiralikhan786'),
            ),
            const SizedBox(height: 32),

            // CTA Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF4ADE80).withOpacity(0.1), const Color(0xFFA855F7).withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(children: [
                const Text('Ready to Get Started?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('Book a free consultation today.', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _launch('https://theteamnak.com/contact'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF4ADE80), Color(0xFF60A5FA), Color(0xFFA855F7)]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text('Get In Touch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactButton({required this.icon, required this.label, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
            Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
          ]),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white.withOpacity(0.3)),
        ]),
      ),
    );
  }
}
