import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Powered by ',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          GestureDetector(
            onTap: () => _launchUrl('https://abdulrehmansarwar.vercel.app'),
            child: const Text(
              'Abdul Rehman',
              style: TextStyle(
                color: Color.fromARGB(255, 249, 240, 4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            ' at ',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          GestureDetector(
            onTap: () => _launchUrl('https://www.linkedin.com/company/acm-uet-lahore/'),
            child: const Text(
              'ACM UET Fellowship',
              style: TextStyle(
                color: Color.fromARGB(255, 249, 240, 4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}