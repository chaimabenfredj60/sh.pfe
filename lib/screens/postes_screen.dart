import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class Post {
  final String id;
  final String title;
  final String author;
  final String? avatarUrl;
  final String category;
  final String content;
  int comments;

  Post({
    required this.id,
    required this.title,
    required this.author,
    this.avatarUrl,
    required this.category,
    required this.content,
    this.comments = 0,
  });
}

class PostesScreen extends StatefulWidget {
  final String language;

  const PostesScreen({
    super.key,
    this.language = 'en',
  });

  @override
  State<PostesScreen> createState() => _PostesScreenState();
}

class _PostesScreenState extends State<PostesScreen> {
  static const Color primary = Color(0xFF00B4A6);
  final _searchCtrl = TextEditingController();
  String _search = '';

  final List<Post> _posts = [
    Post(
        id: '1',
        title: 'aa',
        author: 'SuperAdmin',
        category: 'Banking',
        content: 'aa'),
    Post(
        id: '2',
        title: 'Test',
        author: 'KALAI Milaine',
        category: 'Banking',
        content: 'Cc'),
  ];

  List<Post> get _filtered => _posts
      .where((p) =>
          _search.isEmpty ||
          p.title.toLowerCase().contains(_search.toLowerCase()) ||
          p.author.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  // Breakpoints
  bool _isMobile(BuildContext ctx) => MediaQuery.of(ctx).size.width < 600;
  bool _isTablet(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    return w >= 600 && w < 900;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    final mobile = _isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(mobile ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: mobile ? 10 : 14),
              _buildSearchBar(context),
              SizedBox(height: mobile ? 12 : 16),
              Expanded(
                child: _filtered.isEmpty
                    ? const Center(
                        child: Text('Aucun post trouvé.',
                            style: TextStyle(color: Color(0xFF9E9E9E))))
                    : _buildList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final mobile = _isMobile(context);

    if (mobile) {
      // Stack title/breadcrumb above the coopt button
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text('Poste List',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(width: 8),
            _crumb('Home'),
            const Icon(Icons.chevron_right, size: 13, color: Color(0xFF9E9E9E)),
            _crumb('Postes', active: true),
          ]),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
              icon: const Icon(Icons.person_add_outlined, size: 15),
              label: const Text('Coopt a Talented Employee',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              onPressed: () {},
            ),
          ),
        ],
      );
    }

    // Tablet / Desktop: single row
    return Row(children: [
      const Text('Poste List',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E))),
      const SizedBox(width: 10),
      _crumb('Home'),
      const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
      _crumb('Postes', active: true),
      const Spacer(),
      OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            foregroundColor: primary,
            side: const BorderSide(color: primary),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        icon: const Icon(Icons.person_add_outlined, size: 15),
        label: const Text('Coopt a Talented Employee',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        onPressed: () {},
      ),
    ]);
  }

  // ─── Search + Action Buttons ───────────────────────────────────────────────

  Widget _buildSearchBar(BuildContext context) {
    final mobile = _isMobile(context);

    final searchField = SizedBox(
      height: 36,
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
          prefixIcon:
              const Icon(Icons.search, size: 16, color: Color(0xFFBDBDBD)),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: primary, width: 1.5)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );

    final addBtn = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
      icon: const Icon(Icons.add, size: 16),
      label: Text(mobile ? 'Add' : 'Add Poste',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      onPressed: () => _addPostDialog(),
    );

    final seeBtn = OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
      onPressed: () {},
      child: Text(mobile ? 'My Postes' : 'See My Poste',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    );

    if (mobile) {
      // Full-width search, then buttons row below
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          searchField,
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: addBtn),
            const SizedBox(width: 8),
            Expanded(child: seeBtn),
          ]),
        ],
      );
    }

    // Tablet / Desktop: all in one row
    return Row(children: [
      SizedBox(width: 200, child: searchField),
      const Spacer(),
      addBtn,
      const SizedBox(width: 8),
      seeBtn,
    ]);
  }

  // ─── Posts List / Grid ─────────────────────────────────────────────────────

  Widget _buildList(BuildContext context) {
    final tablet = _isTablet(context);
    final desktop = !_isMobile(context) && !tablet;

    // Desktop / wide tablet → 2-column grid
    if (desktop) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.8,
        ),
        itemCount: _filtered.length,
        itemBuilder: (ctx, i) => _postCard(_filtered[i]),
      );
    }

    // Mobile / tablet → single column list
    return ListView.separated(
      itemCount: _filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) => _postCard(_filtered[i]),
    );
  }

  // ─── Post Card ─────────────────────────────────────────────────────────────

  Widget _postCard(Post p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                  radius: 18,
                  backgroundColor: primary.withOpacity(0.15),
                  child: Text(p.author[0].toUpperCase(),
                      style: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13))),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF1A1A2E))),
                      Text('Posted By : ${p.author}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF9E9E9E))),
                    ]),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(p.category,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFF9800),
                      fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            child: Text(p.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(children: [
              const Icon(Icons.people_outline,
                  size: 16, color: Color(0xFF9E9E9E)),
              const SizedBox(width: 6),
              Text('${p.comments} Comments',
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
              const Spacer(),
              TextButton(
                onPressed: () => _readMore(p),
                child: const Text('Read More',
                    style: TextStyle(
                        color: primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // ─── Dialogs ───────────────────────────────────────────────────────────────

  void _readMore(Post p) => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(p.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('By ${p.author}',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9E9E9E))),
                  const SizedBox(height: 8),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(p.category,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFFF9800),
                              fontWeight: FontWeight.w600))),
                  const SizedBox(height: 12),
                  Text(p.content,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF374151))),
                ]),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'))
            ],
          ));

  void _addPostDialog() {
    final titleC = TextEditingController();
    final contentC = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text('Add Poste',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: SizedBox(
                  width: 360,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextField(
                        controller: titleC,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Titre *',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: primary, width: 2)))),
                    const SizedBox(height: 10),
                    TextField(
                        controller: contentC,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: 'Contenu',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: primary, width: 2)))),
                  ])),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Annuler',
                        style: TextStyle(color: Color(0xFF9E9E9E)))),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (titleC.text.trim().isNotEmpty) {
                        setState(() => _posts.add(Post(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            title: titleC.text.trim(),
                            author: 'Membre',
                            category: 'Banking',
                            content: contentC.text.trim())));
                      }
                      Navigator.pop(ctx);
                    },
                    child: const Text('Ajouter')),
              ],
            ));
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Widget _crumb(String label, {bool active = false}) => Text(label,
      style: TextStyle(
          fontSize: 12,
          color: active ? primary : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal));
}
