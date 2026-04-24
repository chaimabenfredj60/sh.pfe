import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────
class EventItem {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String? imageUrl;
  final bool isPast; // pour afficher la date en rouge

  const EventItem({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.isPast = false,
  });
}

// ── Données de démo ───────────────────────────────────────────────────────────
final List<EventItem> _demoEvents = [
  EventItem(
    id: '1',
    title: 'Cooptation Workshop',
    startDate: DateTime(2023, 7, 10),
    endDate: DateTime(2023, 9, 14),
    isPast: true,
  ),
  EventItem(
    id: '2',
    title: 'Cooptation Summit 2023',
    startDate: DateTime(2023, 7, 19),
    endDate: DateTime(2023, 7, 21),
    isPast: true,
  ),
];

// ── Écran Events ──────────────────────────────────────────────────────────────
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _titleController     = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController   = TextEditingController();

  List<EventItem> get _filtered {
    return _demoEvents.where((e) {
      final matchTitle = _titleController.text.isEmpty ||
          e.title
              .toLowerCase()
              .contains(_titleController.text.toLowerCase());
      return matchTitle;
    }).toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

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
          'List of Events',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF00B4A6),
                side: const BorderSide(color: Color(0xFF00B4A6)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(Icons.person_add_outlined, size: 16),
              label: const Text('Coopt a Talented Employee',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              onPressed: () {},
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE0E0E0)),
        ),
      ),
      body: Column(
        children: [
          // ── Breadcrumb ───────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _crumb('Home'),
                const Icon(Icons.chevron_right,
                    size: 14, color: Color(0xFF9E9E9E)),
                _crumb('Actu & event'),
                const Icon(Icons.chevron_right,
                    size: 14, color: Color(0xFF9E9E9E)),
                _crumb('List of Events', active: true),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),

          // ── Filtres de recherche ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: _searchField(
                    controller: _titleController,
                    label: 'Title Search :',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _searchField(
                    controller: _startDateController,
                    label: 'Start Date Search:',
                    hint: 'YYYY-MM-DD',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _searchField(
                    controller: _endDateController,
                    label: 'End Date Search:',
                    hint: 'YYYY-MM-DD',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Grille des events ────────────────────────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text('Aucun événement trouvé.',
                        style: TextStyle(color: Color(0xFF9E9E9E))),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: _filtered
                          .map((e) => _EventCard(event: e))
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _crumb(String label, {bool active = false}) => Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: active ? const Color(0xFF00B4A6) : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        ),
      );

  Widget _searchField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF555555))),
        const SizedBox(height: 4),
        SizedBox(
          height: 36,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(color: Color(0xFF00B4A6), width: 1.5),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Card événement ────────────────────────────────────────────────────────────
class _EventCard extends StatelessWidget {
  final EventItem event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('yyyy-MM-dd');
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
          // ── En-tête titre + médaille ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                // Médaille décorative
                Column(
                  children: [
                    const Text('V',
                        style: TextStyle(
                            color: Color(0xFF7C3AED),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB300),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star,
                          color: Colors.white, size: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Dates ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Column(
              children: [
                _dateRow(
                    Icons.access_time_outlined, 'Start on', event.startDate, fmt),
                const SizedBox(height: 4),
                _dateRow(
                    Icons.access_time_outlined, 'End on', event.endDate, fmt),
              ],
            ),
          ),

          // ── Image ou placeholder ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: event.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child:
                          Image.network(event.imageUrl!, fit: BoxFit.cover),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported_outlined,
                            size: 36, color: Color(0xFFBDBDBD)),
                        SizedBox(height: 6),
                        Text('No Image Available',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFFBDBDBD))),
                      ],
                    ),
            ),
          ),

          // ── Bouton ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
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
                onPressed: () {},
                child: const Text('Show Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateRow(
      IconData icon, String label, DateTime date, DateFormat fmt) {
    return Row(
      children: [
        Icon(icon, size: 13, color: const Color(0xFF9E9E9E)),
        const SizedBox(width: 4),
        Text('$label ',
            style:
                const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            fmt.format(date),
            style: const TextStyle(
                fontSize: 11,
                color: Color(0xFFE53935),
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}