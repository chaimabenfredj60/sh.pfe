import 'package:flutter/material.dart';

// ─── MODEL ──────────────────────────────────────────────────────────────────

class Poste {
  final String title;
  final String postedBy;
  final String tag;
  final String content;
  final int comments;
  final String? avatarLetter;

  const Poste({
    required this.title,
    required this.postedBy,
    required this.tag,
    required this.content,
    required this.comments,
    this.avatarLetter,
  });
}

// ─── SCREEN ─────────────────────────────────────────────────────────────────

class PostesScreen extends StatefulWidget {
  const PostesScreen({super.key});

  @override
  State<PostesScreen> createState() => _PostesScreenState();
}

class _PostesScreenState extends State<PostesScreen> {
  static const Color primary = Color(0xFF00B4A6);

  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  List<Poste> _postes = [
    const Poste(
      title: 'aa',
      postedBy: 'SuperAdmin',
      tag: 'Banking',
      content: 'aa',
      comments: 0,
      avatarLetter: 'F',
    ),
    const Poste(
      title: 'Test',
      postedBy: 'KALAI Milaine',
      tag: 'Banking',
      content: 'Cc',
      comments: 0,
      avatarLetter: null,
    ),
  ];

  List<Poste> get _filtered {
    if (_query.isEmpty) return _postes;
    final q = _query.toLowerCase();
    return _postes
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.postedBy.toLowerCase().contains(q) ||
            p.content.toLowerCase().contains(q))
        .toList();
  }

  void _openAddPosteDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (_) => AddPosteDialog(
        onSubmit: (newPoste) {
          setState(() => _postes.insert(0, newPoste));
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F6F9),
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchAndActions(),
                  const SizedBox(height: 20),
                  ..._filtered.map((p) => _PosteCard(poste: p)),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  // ── TOP BAR ────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _outlinedBtn(Icons.description_outlined, 'Request a document or information'),
          const SizedBox(width: 10),
          _outlinedBtn(Icons.folder_outlined, 'My documents / responses'),
          const Spacer(),
          const Text('🇺🇸 English',
              style: TextStyle(fontSize: 13, color: Color(0xFF4A5568))),
          const SizedBox(width: 16),
          const Icon(Icons.dark_mode_outlined, size: 20, color: Color(0xFF8A9BB0)),
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 20, color: Color(0xFF8A9BB0)),
          const SizedBox(width: 12),
          Stack(children: [
            const Icon(Icons.notifications_outlined, size: 20, color: Color(0xFF8A9BB0)),
            Positioned(
              right: 0, top: 0,
              child: Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF5252), shape: BoxShape.circle),
              ),
            ),
          ]),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('BOUGUILA Wissem',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E))),
              Text('member',
                  style: TextStyle(fontSize: 10, color: Color(0xFF8A9BB0))),
            ],
          ),
          const SizedBox(width: 10),
          Stack(
            alignment: Alignment.topRight,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: Colors.white),
              ),
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                alignment: Alignment.center,
                child: const Text('56%',
                    style: TextStyle(
                        fontSize: 6,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _outlinedBtn(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 15),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: Color(0xFF00B4A6)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Poste List',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 4),
            Row(children: [
              _crumb('Home', link: true),
              const Icon(Icons.chevron_right, size: 14, color: Color(0xFF8A9BB0)),
              _crumb('Postes'),
            ]),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send, size: 16),
          label: const Text('Coopt a Talented Employee'),
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _crumb(String label, {bool link = false}) {
    return Text(label,
        style: TextStyle(
            fontSize: 12,
            color: link ? primary : const Color(0xFF4A5568),
            fontWeight: link ? FontWeight.w500 : FontWeight.normal));
  }

  // ── SEARCH + ACTIONS ───────────────────────────────────────────────────────

  Widget _buildSearchAndActions() {
    return Row(
      children: [
        // Search
        SizedBox(
          width: 200,
          child: TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0BEC5)),
              prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFFB0BEC5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00B4A6))),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        // Add Poste
        ElevatedButton.icon(
          onPressed: _openAddPosteDialog,
          icon: const Icon(Icons.add, size: 16),
          label: const Text('Add Poste'),
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        const SizedBox(width: 10),
        // See My Poste
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF4A5568),
            side: const BorderSide(color: Color(0xFFE0E0E0)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          child: const Text('See My Poste'),
        ),
      ],
    );
  }

  // ── FOOTER ─────────────────────────────────────────────────────────────────

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('COPYRIGHT © 2026 , All rights Reserved',
              style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
          Row(children: [
            Text('Hand-crafted & Made with ',
                style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
            Icon(Icons.favorite, size: 12, color: Colors.red),
            Text(' by R.O',
                style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
          ]),
        ],
      ),
    );
  }
}

// ─── POSTE CARD ─────────────────────────────────────────────────────────────

class _PosteCard extends StatelessWidget {
  final Poste poste;
  const _PosteCard({required this.poste});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author row
          Row(children: [
            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: poste.avatarLetter != null
                  ? const Color(0xFF00B4A6)
                  : const Color(0xFFE0E0E0),
              child: poste.avatarLetter != null
                  ? Text(poste.avatarLetter!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))
                  : const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(poste.title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E))),
              Text('Posted By : ${poste.postedBy}',
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF8A9BB0))),
            ]),
          ]),
          const SizedBox(height: 12),

          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(poste.tag,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFA726),
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),

          // Content
          Text(poste.content,
              style: const TextStyle(fontSize: 13, color: Color(0xFF4A5568))),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF0F0F0)),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.people_outline,
                    size: 16, color: Color(0xFF8A9BB0)),
                const SizedBox(width: 6),
                Text('${poste.comments} Comments',
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF8A9BB0))),
              ]),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF00B4A6),
                    padding: EdgeInsets.zero),
                child: const Text('Read More',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── ADD POSTE DIALOG ───────────────────────────────────────────────────────

class AddPosteDialog extends StatefulWidget {
  final Function(Poste) onSubmit;
  const AddPosteDialog({super.key, required this.onSubmit});

  @override
  State<AddPosteDialog> createState() => _AddPosteDialogState();
}

class _AddPosteDialogState extends State<AddPosteDialog> {
  static const Color primary = Color(0xFF00B4A6);

  final _titleCtrl = TextEditingController();
  final _descCtrl  = TextEditingController();
  String? _selectedTag;
  bool _hasImage = false;

  static const List<String> _tags = [
    'Fintech', 'Banking', 'Career', 'New', '2023', 'Medical', 'Healthy', 'Adventure',
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleCtrl.text.trim().isEmpty) return;
    widget.onSubmit(Poste(
      title: _titleCtrl.text.trim(),
      postedBy: 'BOUGUILA Wissem',
      tag: _selectedTag ?? 'General',
      content: _descCtrl.text.trim(),
      comments: 0,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Text('Poste',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E))),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.close, size: 16, color: Color(0xFF4A5568)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Image upload area
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: _hasImage
                    ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(color: const Color(0xFFE0E0E0),
                              child: const Center(child: Icon(Icons.image, size: 60, color: Colors.grey))),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined,
                              size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 12),
                          Text('NO IMAGE\nAVAILABLE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[300])),
                        ],
                      ),
              ),
              const SizedBox(height: 12),

              // Upload buttons
              Row(children: [
                ElevatedButton(
                  onPressed: () => setState(() => _hasImage = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                  child: const Text('Upload new img'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => setState(() => _hasImage = false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4A5568),
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                  child: const Text('Reset'),
                ),
              ]),
              const SizedBox(height: 4),
              const Text('Allowed JPG, GIF or PNG.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
              const SizedBox(height: 16),

              // Title field
              const Text('title',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4A5568))),
              const SizedBox(height: 6),
              TextField(
                controller: _titleCtrl,
                decoration: _inputDeco('Enter title'),
              ),
              const SizedBox(height: 16),

              // Description field
              const Text('Description',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4A5568))),
              const SizedBox(height: 6),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: _inputDeco('Enter description'),
              ),
              const SizedBox(height: 16),

              // Tags dropdown
              const Text('Tags',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4A5568))),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedTag,
                    hint: const Text('Select...',
                        style: TextStyle(fontSize: 13, color: Color(0xFFB0BEC5))),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF8A9BB0)),
                    items: _tags.map((tag) => DropdownMenuItem(
                      value: tag,
                      child: Text(tag, style: const TextStyle(fontSize: 13)),
                    )).toList(),
                    onChanged: (v) => setState(() => _selectedTag = v),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    child: const Text('Submit'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4A5568),
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    child: const Text('Discard'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0BEC5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00B4A6))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }
}