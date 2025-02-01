// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rescuesync/screens/homeScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Screen'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const Homescreen()));
          }, icon: const Icon(Icons.turn_left_rounded))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 30),
                  _buildAppInfoSection(),
                  const SizedBox(height: 20),
                  _buildDynamicSections(context),
                  const SizedBox(height: 20),
                  _buildLegalSection(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicSections(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildContactSection()),
          const SizedBox(width: 20),
          Expanded(child: _buildLegalSection()),
        ],
      );
    } else {
      return Column(
        children: [
          _buildContactSection(),
        ],
      );
    }
  }

  Widget _buildHeaderSection() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.emergency_share, size: 80, color: Colors.blue),
        SizedBox(height: 15),
        // ignore: unnecessary_const
        const Text(
          'RescueSync',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Emergency Response Coordination Platform',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildAppInfoSection() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Version', '0.1.0'),
            _buildInfoRow('Developed by', 'Marijua'),
            _buildInfoRow('Powered by', 'Schweis Cooperative'),
            _buildInfoRow('Release Date', 'Jan 2025'),
            const SizedBox(height: 15),
            const Text(
              'RescueSync is an emergency coordination platform designed to help teams respond quickly and effectively to crisis situations through real-time communication and SOS features.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(minHeight: 180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildClickableRow(Icons.email, 'rescuesync@schweis.eu', 'mailto:'),
            _buildClickableRow(Icons.language, 'www.schweis.eu/rescuesync', 'https://'),
            _buildClickableRow(Icons.phone, '+62 822-4153-6495', 'tel:'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection() {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(minHeight: 180),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Legal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Licensed under GPL-3.0 License\n'
              'Copyright © 2025 Schweis Cooperative\n'
              'All rights reserved',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildClickableRow(IconData icon, String text, String prefix) {
    return InkWell(
      onTap: () => _launchUrl(prefix + text),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 15),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}