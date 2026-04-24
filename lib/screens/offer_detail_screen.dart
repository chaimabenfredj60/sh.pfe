import 'package:flutter/material.dart';

class OfferDetailScreen extends StatefulWidget {
  final dynamic offer;
  final VoidCallback? onBack;

  const OfferDetailScreen({
    super.key,
    required this.offer,
    this.onBack,
  });

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  static const Color primary = Color(0xFF00B4A6);

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;

    return Column(
      children: [
        _topBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 20),
                _body(offer),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 TOP BAR
  Widget _topBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          const Spacer(),
          const Text("Offer Details"),
        ],
      ),
    );
  }

  // 🔹 HEADER
  Widget _header() {
    return const Text(
      "Détails de l'offre",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  // 🔹 BODY
  Widget _body(dynamic offer) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ TITLE
          Text(
            offer.title ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // ✅ COMPANY + LOCATION
          Row(
            children: [
              Text(offer.company ?? ''),
              const SizedBox(width: 10),
              const Icon(Icons.location_on, size: 14),
              Text(offer.location ?? ''),
            ],
          ),

          const SizedBox(height: 10),

          // ✅ PRICE
          Text(
            offer.price ?? '',
            style: const TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          // ✅ TAGS
          Wrap(
            spacing: 6,
            children: (offer.tags as List<dynamic>? ?? [])
                .map((t) => Chip(label: Text(t.toString())))
                .toList(),
          ),

          const SizedBox(height: 20),

          // ✅ DESCRIPTION
          Text(
            offer.description ?? '',
            style: const TextStyle(height: 1.5),
          ),

          const SizedBox(height: 20),

          // ✅ INFO
          Row(
            children: [
              _chip(offer.type ?? ''),
              const SizedBox(width: 10),
              _chip(offer.mode ?? ''),
            ],
          ),

          const SizedBox(height: 20),

          // ✅ BUTTONS
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Postuler"),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {},
                child: const Text("Partager"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}