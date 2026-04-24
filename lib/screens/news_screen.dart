import 'package:flutter/material.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────
class NewsArticle {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
  });
}

// ── Données de démo ───────────────────────────────────────────────────────────
const List<NewsArticle> _demoNews = [
  NewsArticle(
    id: '1',
    title: 'Launch of Cooptalite',
    body:
        'We are happy to announce the lunch of our concept of a close community that help each other. Every one of us is an actor to our common success. So don\'t forget : Mutual Aid, generosity, Mind set of sharing... Idea is to test our platform together at a first step ! Please use the desktop to test. Mobile version is still on tunning phase. Please don\'t hesitate to put your feedbacks in the support TAB (when you clik on your name in the top right ;) We will organise a webinar to present all fonctionalities and a demo. I\'m happy to hear from you. Nejd',
    imageUrl: null,
  ),
  NewsArticle(
    id: '2',
    title: 'Bonne Année 2025',
    body:
        'Portalite et Cooptalite vous souhaitent une bonne année 2025 pleine de belles choses pour vous et vos proches !!',
    imageUrl: null,
  ),
];

// ── Écran News ────────────────────────────────────────────────────────────────
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF555555)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'News',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE0E0E0)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _demoNews
              .map((article) => _NewsCard(article: article))
              .toList(),
        ),
      ),
    );
  }
}

// ── Card individuelle ─────────────────────────────────────────────────────────
class _NewsCard extends StatelessWidget {
  final NewsArticle article;
  const _NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image ou placeholder
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: article.imageUrl != null
                ? ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(article.imageUrl!, fit: BoxFit.cover),
                  )
                : const _NoImagePlaceholder(),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.body,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B4A6),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => _showDetails(context, article),
                    child: const Text(
                      'Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, NewsArticle article) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(article.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        content: SingleChildScrollView(
          child: Text(article.body,
              style:
                  const TextStyle(fontSize: 13, color: Color(0xFF555555), height: 1.6)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer',
                style: TextStyle(color: Color(0xFF00B4A6))),
          ),
        ],
      ),
    );
  }
}

// ── Placeholder image ─────────────────────────────────────────────────────────
class _NoImagePlaceholder extends StatelessWidget {
  const _NoImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_not_supported_outlined,
            size: 40, color: Color(0xFFBDBDBD)),
        SizedBox(height: 8),
        Text('No Image Available',
            style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
      ],
    );
  }
}