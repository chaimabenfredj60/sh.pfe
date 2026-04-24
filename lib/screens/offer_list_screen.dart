import 'package:flutter/material.dart';

// ─── COLORS ──────────────────────────────────────────────────────────────────
const Color kPrimary     = Color(0xFF00B4A6);
const Color kBg          = Color(0xFFF5F6FA);
const Color kBorder      = Color(0xFFE5E7EB);
const Color kGrey        = Color(0xFF6B7280);
const Color kLightGrey   = Color(0xFF9CA3AF);
const Color kDark        = Color(0xFF111827);
const Color kPrimaryLight= Color(0xFFE6F9F7);
const Color kTagBg       = Color(0xFFF3F4F6);

// ─── OPTIONS ─────────────────────────────────────────────────────────────────
const List<String> kTypeOptions     = ['REMOTE','HYBRIDE','ON SITE'];
const List<String> kCategoryOptions = ['IT','NETWORK','TELECOM','DEVELOPPEMENT','DATA','CYBER','DEVOPS','INFRA','GESTION DE PROJET','QA','SYSTEM INFO'];
const List<String> kContractOptions = ['CDD','CDI','FREELANCE','PARTTIME'];
const List<Map<String,String>> kRecentOptions = [
  {'value':'RATE_ASC','label':'RATE ↑'},
  {'value':'RATE_DESC','label':'RATE ↓'},
  {'value':'START','label':'START'},
];
const List<String> kSkillOptions = ['React','Node.js','Python','Java','AWS','Docker','Kubernetes','SQL','TypeScript'];

// ─── MODEL ───────────────────────────────────────────────────────────────────
class Offer {
  final int id;
  final String title, company, location, price, description, type, mode, duration;
  final List<String> tags;
  final int extraTags, candidates;
  final bool expired;
  // detail fields
  final String postedOn, startDate, experience, fullDescription;

  Offer({
    required this.id, required this.title, required this.company,
    required this.location, required this.price, required this.description,
    required this.tags, required this.extraTags, required this.type,
    required this.mode, required this.expired, required this.duration,
    required this.candidates,
    this.postedOn = '', this.startDate = '', this.experience = '',
    this.fullDescription = '',
  });
}

final List<Offer> kInitialOffers = [
  Offer(
    id:1, title:'Business Analyst Data Assurance', company:'SQLI', location:'Paris',
    price:'500,00 €',
    description:"Interface entre métiers de l'assurance vie et équipes IT/Data pour garantir cohérence.",
    tags:['BUSINESS ANALYSIS','DATA MODELING','ASSURANCE VIE','ETL/ELT','DATA WAREHOUSE','RECETTE FONCTIONNELLE','USER STORIES','SPÉCIFICATIONS FONCTIONNELLES','FINANCE','BANQUE PATRIMONIALE'],
    extraTags:0, type:'CDI', mode:'HYBRIDE', expired:false, duration:'LONGUE', candidates:0,
    postedOn:'21 04 2026, 04:09 PM', startDate:'01/05/2026', experience:'5 ans',
    fullDescription: '"Dans un contexte de transformation, de modernisation des systèmes d\'information et de renforcement des exigences réglementaires, l\'entreprise renforce ses équipes Data.\n\nLe/la Business Analyst Data Assurance intervient comme interface entre les métiers de l\'assurance vie et les équipes IT/Data, afin de garantir la cohérence, la qualité et la valorisation des données métier.\n\nUne expérience dans les secteurs de l\'assurance vie, de la banque ou de la finance est vivement recommandée, notamment sur les connaissances des données contrats, clients, apporteurs ainsi que sur des flux de données liés aux domaines assurantiels ou aux données clients."\n\n"POSTE BASE SUR PARIS\n\n   1.\n\nAnalyse des besoins métier\n\nRecueillir, analyser et formaliser les besoins des directions métiers (actuariat, gestion, finance, risques, conformité...)\nAnimer des ateliers de cadrage fonctionnel avec les parties prenantes\nComprendre et intégrer les enjeux spécifiques du secteur de l\'assurance vie et de la banque patrimoniale\nFormaliser les expressions de besoin sous forme de : user stories ou spécifications fonctionnelles\n\n   1.\n\nModélisation des données métier\n\nConcevoir et maintenir les modèles de données (conceptuels et logiques)\nModéliser les entités clés de l\'assurance vie et de la banque patrimoniale\nDéfinir et documenter : règles de gestion, dépendances entre données, dictionnaires de données\nGarantir la cohérence fonctionnelle et métier des modèles\n\n   1.\n\nInterface entre métiers et équipes Data / IT\n\nTraduire les besoins métier en exigences fonctionnelles data\nParticiper à la définition des flux d\'alimentation (ETL/ELT)\nContribuer à la conception de data warehouses et data marts\n\n   1.\n\nRecette fonctionnelle et qualité des données\n\nDéfinir les stratégies et cas de tests fonctionnels\nParticiper aux phases de recette utilisateur (UAT)\nVérifier la fiabilité, la complétude et la cohérence des données\nIdentifier, qualifier et suivre les anomalies\nContribuer à l\'amélioration continue de la qualité des données"',
  ),
  Offer(id:2, title:'Ingénieur DevOps AWS', company:'PORTALITE', location:'Saint Quentin', price:'550,00 €', description:'Infra cloud AWS Kubernetes Terraform.', tags:['DEVOPS','CLOUD'], extraTags:10, type:'FREELANCE', mode:'HYBRIDE', expired:false, duration:'10j', candidates:1, postedOn:'20 04 2026, 10:00 AM', startDate:'01/06/2026', experience:'3 ans', fullDescription:'Infra cloud AWS Kubernetes Terraform.'),
  Offer(id:3, title:'Développeur Full Stack React/Node', company:'TECHCORP', location:'Lyon', price:'480,00 €', description:"Développement d'applications web modernes avec React et Node.js.", tags:['DEVELOPPEMENT','REACT'], extraTags:3, type:'CDI', mode:'REMOTE', expired:false, duration:'5j', candidates:4, postedOn:'19 04 2026, 09:00 AM', startDate:'15/05/2026', experience:'2 ans', fullDescription:"Développement d'applications web modernes avec React et Node.js."),
  Offer(id:4, title:'Data Engineer Spark', company:'DATALAB', location:'Bordeaux', price:'600,00 €', description:'Conception et maintenance de pipelines de données avec Apache Spark.', tags:['DATA','SPARK'], extraTags:2, type:'FREELANCE', mode:'ON SITE', expired:false, duration:'15j', candidates:2, postedOn:'18 04 2026, 08:00 AM', startDate:'01/07/2026', experience:'4 ans', fullDescription:'Conception et maintenance de pipelines de données avec Apache Spark.'),
  Offer(id:5, title:'Chef de Projet IT', company:'CONSULT GROUP', location:'Marseille', price:'520,00 €', description:'Pilotage de projets IT en environnement bancaire.', tags:['GESTION DE PROJET'], extraTags:0, type:'CDD', mode:'HYBRIDE', expired:false, duration:'12j', candidates:0, postedOn:'17 04 2026, 07:00 AM', startDate:'01/06/2026', experience:'6 ans', fullDescription:'Pilotage de projets IT en environnement bancaire.'),
];

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
class OfferListScreen extends StatefulWidget {
  final void Function(dynamic offer)? onOfferTap;
  final String activeSubItem;

  const OfferListScreen({
    super.key,
    this.onOfferTap,
    this.activeSubItem = 'Liste des offres',
  });

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  List<Offer> _offers = List.from(kInitialOffers);
  List<Offer> _myOffers = [];
  String _search = '';
  String? _selectedType, _selectedCategory, _selectedContract, _selectedRecent;
  final TextEditingController _searchCtrl = TextEditingController();
  Offer? _detailOffer; // null = list, non-null = detail view

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  double _extractPrice(String price) =>
      double.tryParse(price.replaceAll('€','').replaceAll(',','.').trim()) ?? 0;

  List<Offer> get _filtered {
    List<Offer> list = List.from(_offers);
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      list = list.where((o) =>
        o.title.toLowerCase().contains(q) ||
        o.company.toLowerCase().contains(q) ||
        o.location.toLowerCase().contains(q)).toList();
    }
    if (_selectedType != null) list = list.where((o) => o.mode == _selectedType).toList();
    if (_selectedContract != null) list = list.where((o) => o.type == _selectedContract).toList();
    if (_selectedCategory != null) list = list.where((o) => o.tags.contains(_selectedCategory)).toList();
    if (_selectedRecent == 'RATE_ASC') list.sort((a,b) => _extractPrice(a.price).compareTo(_extractPrice(b.price)));
    if (_selectedRecent == 'RATE_DESC') list.sort((a,b) => _extractPrice(b.price).compareTo(_extractPrice(a.price)));
    if (_selectedRecent == 'START') list.sort((a,b) => a.duration.compareTo(b.duration));
    return list;
  }

  void _openAddOffer() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => AddOfferDialog(
        onSubmit: (offer) => setState(() { _offers.add(offer); _myOffers.add(offer); }),
      ),
    );
  }

  void _openDetail(Offer offer) => setState(() => _detailOffer = offer);
  void _closeDetail() => setState(() => _detailOffer = null);

  @override
  Widget build(BuildContext context) {
    // ── Offer Detail View ──
    if (_detailOffer != null) {
      return OfferDetailScreen(
        offer: _detailOffer!,
        onBack: _closeDetail,
      );
    }

    final title = widget.activeSubItem.isNotEmpty ? widget.activeSubItem : 'Liste des offres';
    final filtered = _filtered;
    final cdiCount = _offers.where((o) => o.type == 'CDI').length;
    final freelanceCount = _offers.where((o) => o.type == 'FREELANCE').length;

    // ── My Offers view ──
    if (widget.activeSubItem == 'Mes offres') {
      return Column(children: [
        _TopBar(onAddTap: _openAddOffer),
        Expanded(child: Container(
          color: kBg,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(child: _StatCard(icon: Icons.work_outline, count: _myOffers.length, label: 'My Offers')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.check_circle_outline, count: 0, label: 'Active')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.schedule_outlined, count: 0, label: 'Pending')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.person_add_outlined, count: 0, label: 'Applications')),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.trending_up_outlined, count: 0, label: 'Accepted')),
              ]),
              const SizedBox(height: 20),
              SizedBox(
                width: 600, height: 40,
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _search = v),
                  decoration: _searchDecoration('Search by title, skill, company...'),
                ),
              ),
              const SizedBox(height: 40),
              if (_myOffers.isEmpty)
                Center(child: Column(children: [
                  Container(width: 80, height: 80,
                    decoration: const BoxDecoration(color: kPrimaryLight, shape: BoxShape.circle),
                    child: const Icon(Icons.work_outline, size: 40, color: kPrimary)),
                  const SizedBox(height: 20),
                  const Text('No offers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
                  const SizedBox(height: 8),
                  const Text("You don't have any associated offers yet.", style: TextStyle(fontSize: 14, color: kLightGrey)),
                ]))
              else
                ..._myOffers.map((o) => GestureDetector(
                  onTap: () => _openDetail(o),
                  child: _OfferCard(offer: o),
                )),
            ]),
          ),
        )),
      ]);
    }

    // ── Liste des offres view ──
    return Column(children: [
      _TopBar(onAddTap: _openAddOffer),
      Expanded(child: Container(
        color: kBg,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kDark)),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _StatCard(icon: Icons.work_outline, count: _offers.length, label: 'Available offers')),
              const SizedBox(width: 16),
              Expanded(child: _StatCard(icon: Icons.work_history_outlined, count: cdiCount, label: 'CDI')),
              const SizedBox(width: 16),
              Expanded(child: _StatCard(icon: Icons.person_outline, count: freelanceCount, label: 'FREELANCE')),
            ]),
            const SizedBox(height: 20),
            Wrap(spacing: 10, runSpacing: 10, crossAxisAlignment: WrapCrossAlignment.center, children: [
              SizedBox(
                width: 340, height: 40,
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _search = v),
                  decoration: _searchDecoration('Search...'),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              _FilterChip(label: 'Type', options: kTypeOptions, value: _selectedType, onChange: (v) => setState(() => _selectedType = v)),
              _FilterChip(label: 'Category', options: kCategoryOptions, value: _selectedCategory, onChange: (v) => setState(() => _selectedCategory = v)),
              _FilterChip(label: 'Contract', options: kContractOptions, value: _selectedContract, onChange: (v) => setState(() => _selectedContract = v)),
              _FilterChip(label: 'Rece…', options: kRecentOptions.map((e) => e['value']!).toList(), labels: kRecentOptions.map((e) => e['label']!).toList(), value: _selectedRecent, onChange: (v) => setState(() => _selectedRecent = v)),
              SizedBox(height: 40, child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.tune, size: 16),
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(horizontal: 18), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13), elevation: 0),
              )),
              SizedBox(height: 40, child: OutlinedButton.icon(
                onPressed: _openAddOffer,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('+ Request Add Offer'),
                style: OutlinedButton.styleFrom(foregroundColor: kPrimary, side: const BorderSide(color: kPrimary, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(horizontal: 14), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              )),
            ]),
            const SizedBox(height: 12),
            Text('${filtered.length} result(s)', style: const TextStyle(fontSize: 13, color: kGrey, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              const Padding(padding: EdgeInsets.only(top: 40), child: Center(child: Text('No offers match your filters.', style: TextStyle(color: kLightGrey, fontSize: 15))))
            else
              ...filtered.map((o) => GestureDetector(
                onTap: () => _openDetail(o),
                child: _OfferCard(offer: o),
              )),
          ]),
        ),
      )),
    ]);
  }

  InputDecoration _searchDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: kLightGrey, fontSize: 13),
    prefixIcon: const Icon(Icons.search, color: kLightGrey, size: 18),
    contentPadding: const EdgeInsets.symmetric(vertical: 0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: kBorder)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: kBorder)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: kPrimary)),
    filled: true, fillColor: Colors.white,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// OFFER DETAIL SCREEN  (captures 1 & 2)
// ═══════════════════════════════════════════════════════════════════════════════
class OfferDetailScreen extends StatefulWidget {
  final Offer offer;
  final VoidCallback onBack;
  const OfferDetailScreen({super.key, required this.offer, required this.onBack});

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  // ignore: unused_field
  int _trustRating = 0; // stars chosen before AddCV

  void _openAddCV() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => _CooptDialog(offer: widget.offer),
    );
  }

  void _openApplyToOffer() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => _ApplyToOfferDialog(offer: widget.offer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;
    return Column(
      children: [
        // ── Top bar ──
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(children: [
            IconButton(onPressed: widget.onBack, icon: const Icon(Icons.arrow_back, color: kGrey)),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.description_outlined, size: 15),
              label: const Text('Request a document'),
              style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.folder_outlined, size: 15),
              label: const Text('My documents'),
              style: OutlinedButton.styleFrom(foregroundColor: kPrimary, side: const BorderSide(color: kPrimary, width: 1.5), textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
            ),
            const Spacer(),
            const Icon(Icons.notifications_none, color: kGrey),
          ]),
        ),

        // ── Content ──
        Expanded(
          child: Container(
            color: kBg,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ── Mini stat cards (Applications, Accepted, Shares, Avg. Score) ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(children: [
                      Expanded(child: _MiniStatCard(icon: Icons.star_border, iconColor: Colors.amber, count: 0, label: 'Applications')),
                      const SizedBox(width: 16),
                      Expanded(child: _MiniStatCard(icon: Icons.check_circle_outline, iconColor: kPrimary, count: 0, label: 'Accepted')),
                      const SizedBox(width: 16),
                      Expanded(child: _MiniStatCard(icon: Icons.share_outlined, iconColor: Colors.orange, count: 0, label: 'Shares')),
                      const SizedBox(width: 16),
                      Expanded(child: _MiniStatCardScore(icon: Icons.emoji_events_outlined, iconColor: Colors.purple, score: '25%', label: 'Avg. Score')),
                    ]),
                  ),

                  // ── Offer main card ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFF3F4F6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(offer.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kDark)),
                                    const SizedBox(height: 8),
                                    Wrap(spacing: 8, runSpacing: 6, children: [
                                      _DetailBadge(offer.company, bg: kPrimaryLight, fg: kPrimary),
                                      _DetailBadge(offer.location, icon: Icons.location_on_outlined, bg: kTagBg, fg: kGrey),
                                      _DetailBadge(offer.type, bg: const Color(0xFFDCFCE7), fg: const Color(0xFF16A34A)),
                                      _DetailBadge(offer.mode, bg: const Color(0xFFFFF7ED), fg: const Color(0xFFEA580C)),
                                      if (offer.tags.isNotEmpty && offer.tags.length > 2)
                                        _DetailBadge(offer.tags[2].length > 3 ? offer.tags[2].substring(0,2) : offer.tags[2], bg: kPrimaryLight, fg: kPrimary),
                                    ]),
                                  ],
                                )),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(6)),
                                  child: const Text('SHARED', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1)),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),

                          // Meta grid
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(child: _MetaItem(icon: Icons.calendar_today_outlined, label: 'Posted on', value: offer.postedOn.isNotEmpty ? offer.postedOn : '21 04 2026, 04:09 PM')),
                                  Expanded(child: _MetaItem(icon: Icons.work_outline, label: 'Start', value: offer.startDate.isNotEmpty ? offer.startDate : '01/05/2026')),
                                  Expanded(child: _MetaItem(icon: Icons.check_circle_outline, label: 'Experience', value: offer.experience.isNotEmpty ? offer.experience : '5 ans')),
                                ]),
                                const SizedBox(height: 16),
                                Row(children: [
                                  Expanded(child: _MetaItem(icon: Icons.card_giftcard_outlined, label: 'Daily Rate', value: offer.price)),
                                  Expanded(child: _MetaItem(icon: Icons.timelapse_outlined, label: 'Duration', value: offer.duration)),
                                  const Expanded(child: SizedBox()),
                                ]),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),

                          // Tags
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                            child: Wrap(spacing: 8, runSpacing: 8, children: offer.tags.map((t) => _SkillTag(t)).toList()),
                          ),
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),

                          // Full description
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                offer.fullDescription.isNotEmpty ? offer.fullDescription : offer.description,
                                style: const TextStyle(fontSize: 13, color: kDark, height: 1.7),
                              ),
                            ),
                          ),

                          // Fill rate bar
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(children: [
                              const Text('Fill rate', style: TextStyle(fontSize: 13, color: kLightGrey)),
                              const Spacer(),
                              Text('0/${offer.candidates == 0 ? 1 : offer.candidates}', style: const TextStyle(fontSize: 13, color: kLightGrey)),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0,
                                minHeight: 6,
                                backgroundColor: const Color(0xFFE5E7EB),
                                valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Bottom action bar ──
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            child: Row(
                              children: [
                                // Add CVs button
                                ElevatedButton.icon(
                                  onPressed: _openAddCV,
                                  icon: const Icon(Icons.refresh, size: 16),
                                  label: const Text('Add CVs'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimary, foregroundColor: Colors.white,
                                    elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Apply to Offer button
                                ElevatedButton.icon(
                                  onPressed: _openApplyToOffer,
                                  icon: const Icon(Icons.business_center_outlined, size: 16),
                                  label: const Text('Apply to Offer'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white,
                                    elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ),
                                const Spacer(),
                                // Score
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kBorder),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(children: [
                                    Icon(Icons.emoji_events_outlined, size: 16, color: kPrimary),
                                    const SizedBox(width: 6),
                                    const Text('Score: 0%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kDark)),
                                  ]),
                                ),
                                const SizedBox(width: 10),
                                // Share icon
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.share_outlined, size: 18, color: kGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COOPT (ADD CVs) DIALOG  — capture 3 & 4
// ═══════════════════════════════════════════════════════════════════════════════
class _CooptDialog extends StatefulWidget {
  final Offer offer;
  const _CooptDialog({required this.offer});
  @override
  State<_CooptDialog> createState() => _CooptDialogState();
}

class _CooptDialogState extends State<_CooptDialog> {
  int _stars = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
              child: Row(children: [
                const Icon(Icons.business_center_outlined, color: kDark, size: 20),
                const SizedBox(width: 8),
                const Text('Coopt a candidate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kDark)),
                const Spacer(),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: kLightGrey), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
              ]),
            ),

            // Trust rate tooltip area
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(8)),
              child: const Text('please choose your trust rate\non candidate !', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 10),

            // Stars + Upload label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                ...List.generate(5, (i) => GestureDetector(
                  onTap: () => setState(() => _stars = i + 1),
                  child: Icon(i < _stars ? Icons.star : Icons.star_border, color: Colors.amber, size: 30),
                )),
                const SizedBox(width: 14),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.upload_outlined, color: kPrimary, size: 18),
                  label: const Text('Upload', style: TextStyle(color: kPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ),
              ]),
            ),
            const SizedBox(height: 16),

            // Upload CV label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                const Icon(Icons.refresh, color: kPrimary, size: 16),
                const SizedBox(width: 6),
                const Text('Upload CV', style: TextStyle(color: kPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
              ]),
            ),
            const SizedBox(height: 10),

            // Drop zone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _DropZone(),
            ),
            const SizedBox(height: 20),

            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(children: [
                Expanded(child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Add CVs'),
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(vertical: 12), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                )),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.business_center_outlined, size: 16),
                  label: const Text('Apply to Offer'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(vertical: 12), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                )),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// APPLY TO OFFER DIALOG  — capture 5
// ═══════════════════════════════════════════════════════════════════════════════
class _ApplyToOfferDialog extends StatefulWidget {
  final Offer offer;
  const _ApplyToOfferDialog({required this.offer});
  @override
  State<_ApplyToOfferDialog> createState() => _ApplyToOfferDialogState();
}

class _ApplyToOfferDialogState extends State<_ApplyToOfferDialog> {
  final Map<String,int> _ratings = {};

  @override
  Widget build(BuildContext context) {
    final skills = widget.offer.tags;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
              child: Row(children: [
                const Icon(Icons.business_center_outlined, color: kDark, size: 20),
                const SizedBox(width: 8),
                const Text('Apply to offer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kDark)),
                const Spacer(),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: kLightGrey), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
              ]),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),

            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload CV (optional)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(children: [
                      const Icon(Icons.refresh, color: kPrimary, size: 16),
                      const SizedBox(width: 6),
                      const Text('Upload CV', style: TextStyle(color: kPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 6),
                      const Text('(optional)', style: TextStyle(color: kLightGrey, fontSize: 13)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: _DropZone(),
                  ),

                  // Self-assessment
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(children: [
                      const Icon(Icons.star_border, color: kPrimary, size: 16),
                      const SizedBox(width: 6),
                      const Text('Self-assessment', style: TextStyle(color: kPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                    ]),
                  ),

                  // Skills rating list
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    decoration: BoxDecoration(border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: skills.asMap().entries.map((e) {
                        final skill = e.value;
                        final isLast = e.key == skills.length - 1;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(children: [
                                Expanded(child: Text(skill, style: const TextStyle(fontSize: 13, color: kDark, fontWeight: FontWeight.w500))),
                                Row(children: List.generate(5, (si) => GestureDetector(
                                  onTap: () => setState(() => _ratings[skill] = si + 1),
                                  child: Icon(
                                    si < (_ratings[skill] ?? 0) ? Icons.star : Icons.star_border,
                                    color: const Color(0xFFD1D5DB),
                                    size: 22,
                                  ),
                                ))),
                              ]),
                            ),
                            if (!isLast) const Divider(height: 1, color: Color(0xFFF3F4F6), indent: 16, endIndent: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),

            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: kBorder), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
                  child: const Text('Cancel', style: TextStyle(color: kDark, fontSize: 13)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  child: const Text('Apply'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── SHARED DROP ZONE ────────────────────────────────────────────────────────
class _DropZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          border: Border.all(color: kBorder, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_download_outlined, size: 36, color: kLightGrey),
            const SizedBox(height: 8),
            RichText(text: const TextSpan(
              children: [
                TextSpan(text: 'Drop your receipt here or click to browse', style: TextStyle(fontSize: 13, color: kLightGrey)),
                TextSpan(text: 'PDF, DOCX', style: TextStyle(fontSize: 13, color: kDark, fontWeight: FontWeight.w600)),
                TextSpan(text: ' — 15 Mo max', style: TextStyle(fontSize: 13, color: kLightGrey)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

// ─── DETAIL HELPERS ──────────────────────────────────────────────────────────
class _MiniStatCard extends StatelessWidget {
  final IconData icon; final Color iconColor; final int count; final String label;
  const _MiniStatCard({required this.icon, required this.iconColor, required this.count, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFF3F4F6))),
    child: Row(children: [
      Icon(icon, color: iconColor, size: 22),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$count', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kDark)),
        Text(label, style: const TextStyle(fontSize: 12, color: kLightGrey)),
      ]),
    ]),
  );
}

class _MiniStatCardScore extends StatelessWidget {
  final IconData icon; final Color iconColor; final String score; final String label;
  const _MiniStatCardScore({required this.icon, required this.iconColor, required this.score, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFF3F4F6))),
    child: Row(children: [
      Icon(icon, color: iconColor, size: 22),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(score, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kDark)),
        Text(label, style: const TextStyle(fontSize: 12, color: kLightGrey)),
      ]),
    ]),
  );
}

class _DetailBadge extends StatelessWidget {
  final String label; final Color bg, fg; final IconData? icon;
  const _DetailBadge(this.label, {required this.bg, required this.fg, this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      if (icon != null) ...[Icon(icon, size: 12, color: fg), const SizedBox(width: 4)],
      Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
    ]),
  );
}

class _MetaItem extends StatelessWidget {
  final IconData icon; final String label, value;
  const _MetaItem({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 16, color: kPrimary),
    const SizedBox(width: 8),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: kLightGrey, fontWeight: FontWeight.w500)),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kDark)),
    ]),
  ]);
}

class _SkillTag extends StatelessWidget {
  final String label;
  const _SkillTag(this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFED7AA))),
    child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFEA580C))),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final VoidCallback onAddTap;
  const _TopBar({required this.onAddTap});
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(children: [
      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.description_outlined, size: 15), label: const Text('Request a document'),
        style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)))),
      const SizedBox(width: 8),
      OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.folder_outlined, size: 15), label: const Text('My documents'),
        style: OutlinedButton.styleFrom(foregroundColor: kPrimary, side: const BorderSide(color: kPrimary, width: 1.5), textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)))),
      const Spacer(),
      const Icon(Icons.notifications_none, color: kGrey),
    ]),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD / FILTER CHIP / OFFER CARD (unchanged)
// ═══════════════════════════════════════════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon; final int count; final String label;
  const _StatCard({required this.icon, required this.count, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFF3F4F6)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0,1))]),
    child: Row(children: [
      Container(width: 46, height: 46, decoration: BoxDecoration(color: kPrimaryLight, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: kPrimary, size: 22)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$count', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: kDark)),
        Text(label, style: const TextStyle(fontSize: 12, color: kLightGrey, fontWeight: FontWeight.w500)),
      ])),
    ]),
  );
}

class _FilterChip extends StatelessWidget {
  final String label; final List<String> options; final List<String>? labels; final String? value; final void Function(String?) onChange;
  const _FilterChip({required this.label, required this.options, this.labels, required this.value, required this.onChange});

  String _displayLabel() {
    if (value == null) return label;
    final idx = options.indexOf(value!);
    if (labels != null && idx >= 0) return labels![idx];
    return value!.length > 8 ? '${value!.substring(0,8)}…' : value!;
  }

  @override
  Widget build(BuildContext context) {
    final active = value != null;
    return PopupMenuButton<String>(
      onSelected: (v) => onChange(v),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) => options.asMap().entries.map((e) {
        final lbl = labels != null ? labels![e.key] : e.value;
        return PopupMenuItem<String>(value: e.value, child: Row(children: [
          if (value == e.value) ...[const Icon(Icons.check, size: 14, color: kPrimary), const SizedBox(width: 8)],
          Text(lbl, style: TextStyle(fontSize: 13, fontWeight: value == e.value ? FontWeight.w600 : FontWeight.normal, color: value == e.value ? kPrimary : kDark)),
        ]));
      }).toList(),
      child: Container(
        height: 40, padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: active ? kPrimary : kBorder, width: 1.5), borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(_displayLabel(), style: TextStyle(fontSize: 13, fontWeight: active ? FontWeight.w600 : FontWeight.normal, color: active ? kPrimary : const Color(0xFF374151))),
          const SizedBox(width: 4),
          if (active)
            GestureDetector(onTap: () => onChange(null), child: const Icon(Icons.close, size: 14, color: kLightGrey))
          else
            const Icon(Icons.keyboard_arrow_down, size: 16, color: kLightGrey),
        ]),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final Offer offer;
  const _OfferCard({required this.offer});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFF3F4F6)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 5, offset: const Offset(0,1))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(offer.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kDark)),
          const SizedBox(height: 2),
          Text('${offer.company} • ${offer.location}', style: const TextStyle(fontSize: 13, color: kGrey)),
        ])),
        const SizedBox(width: 10),
        _Badge(offer.type, bg: kPrimaryLight, fg: kPrimary),
        const SizedBox(width: 6),
        _Badge(offer.mode, bg: kTagBg, fg: kGrey),
      ]),
      const SizedBox(height: 8),
      Text(offer.description, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5)),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: Wrap(spacing: 6, runSpacing: 4, children: [
          ...offer.tags.take(2).map((t) => _TagChip(t)),
          if (offer.extraTags > 0) _TagChip('+${offer.extraTags}', dim: true),
        ])),
        const SizedBox(width: 10),
        Text(offer.price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kPrimary)),
        const SizedBox(width: 14),
        const Icon(Icons.access_time, size: 13, color: kLightGrey),
        const SizedBox(width: 3),
        Text(offer.duration, style: const TextStyle(fontSize: 12, color: kLightGrey)),
        const SizedBox(width: 12),
        const Icon(Icons.person_outline, size: 13, color: kLightGrey),
        const SizedBox(width: 3),
        Text('${offer.candidates}', style: const TextStyle(fontSize: 12, color: kLightGrey)),
      ]),
    ]),
  );
}

class _Badge extends StatelessWidget {
  final String label; final Color bg, fg;
  const _Badge(this.label, {required this.bg, required this.fg});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)));
}

class _TagChip extends StatelessWidget {
  final String label; final bool dim;
  const _TagChip(this.label, {this.dim = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(color: kTagBg, borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: dim ? kLightGrey : const Color(0xFF374151))));
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADD OFFER DIALOG (unchanged from before)
// ═══════════════════════════════════════════════════════════════════════════════
class AddOfferDialog extends StatefulWidget {
  final void Function(Offer) onSubmit;
  const AddOfferDialog({super.key, required this.onSubmit});
  @override
  State<AddOfferDialog> createState() => _AddOfferDialogState();
}

class _AddOfferDialogState extends State<AddOfferDialog> {
  final _descCtrl = TextEditingController();
  final _shortDescCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _startDateCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();
  String? _type, _category, _contract;
  List<String> _skills = [];
  bool _exclusive = false;

  @override
  void dispose() {
    _descCtrl.dispose(); _shortDescCtrl.dispose(); _titleCtrl.dispose();
    _expCtrl.dispose(); _addressCtrl.dispose(); _startDateCtrl.dispose(); _durationCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleCtrl.text.trim().isEmpty) return;
    List<String> allTags = [];
    if (_category != null) allTags.add(_category!);
    allTags.addAll(_skills);
    widget.onSubmit(Offer(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleCtrl.text.trim(), company: '', location: _addressCtrl.text.trim(), price: '',
      description: _shortDescCtrl.text.trim().isNotEmpty ? _shortDescCtrl.text.trim() : _descCtrl.text.trim(),
      tags: allTags, extraTags: 0, type: _contract ?? 'FREELANCE',
      mode: _type ?? 'HYBRIDE', expired: false,
      duration: _durationCtrl.text.trim().isNotEmpty ? _durationCtrl.text.trim() : '0j',
      candidates: 0,
      postedOn: DateTime.now().toString(),
      startDate: _startDateCtrl.text.trim(),
      experience: _expCtrl.text.trim(),
      fullDescription: _descCtrl.text.trim(),
    ));
    Navigator.of(context).pop();
  }

  Widget _inputField(TextEditingController ctrl, String hint, {int maxLines = 1}) => TextField(
    controller: ctrl, maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint, hintStyle: const TextStyle(color: kLightGrey, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kBorder, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kPrimary, width: 1.5)),
    ),
    style: const TextStyle(fontSize: 13),
  );

  Widget _labeledField(String label, TextEditingController ctrl, String hint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
      const SizedBox(height: 4), _inputField(ctrl, hint),
    ]);

  Widget _labeledDropdown(String lbl, List<String> options, String? value, void Function(String?) onChange) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(lbl, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
      const SizedBox(height: 4),
      DropdownButtonFormField<String>(
        value: value,
        hint: const Text('Select...', style: TextStyle(fontSize: 13, color: kLightGrey)),
        items: options.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 13)))).toList(),
        onChanged: onChange,
        decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kBorder)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kBorder, width: 1.5)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: kPrimary, width: 1.5))),
        dropdownColor: Colors.white, icon: const Icon(Icons.keyboard_arrow_down, color: kLightGrey),
      ),
    ]);

  Widget _labeledMultiSelectSkills(String lbl, List<String> options, List<String> selected, void Function(List<String>) onChange) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(border: Border.all(color: kLightGrey, width: 1.5), shape: BoxShape.circle), child: const Center(child: Text('?', style: TextStyle(fontSize: 10, color: kLightGrey, fontWeight: FontWeight.w700)))),
        const SizedBox(width: 4),
        Text(lbl, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
      ]),
      const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(border: Border.all(color: kBorder, width: 1.5), borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (selected.isNotEmpty)
            Padding(padding: const EdgeInsets.fromLTRB(12,8,12,8), child: Wrap(spacing: 6, runSpacing: 4, children: selected.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(6)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(skill, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(width: 4),
                GestureDetector(onTap: () { final n = List<String>.from(selected); n.remove(skill); onChange(n); }, child: const Icon(Icons.close, size: 14, color: Colors.white)),
              ]),
            )).toList())),
          PopupMenuButton<String>(
            onSelected: (skill) { if (!selected.contains(skill)) { final n = List<String>.from(selected); n.add(skill); onChange(n); } },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            itemBuilder: (_) => options.where((opt) => !selected.contains(opt)).map((skill) => PopupMenuItem<String>(value: skill, child: Text(skill, style: const TextStyle(fontSize: 13, color: kDark)))).toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(border: Border(top: selected.isNotEmpty ? const BorderSide(color: kBorder) : BorderSide.none)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(selected.isEmpty ? 'Select...' : 'Add more', style: TextStyle(fontSize: 13, color: selected.isEmpty ? kLightGrey : const Color(0xFF374151))),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: kLightGrey),
              ]),
            ),
          ),
        ]),
      ),
    ]);

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680, maxHeight: 700),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(padding: const EdgeInsets.fromLTRB(20,16,16,16), child: Row(children: [
          const Icon(Icons.work_outline, color: kDark, size: 20), const SizedBox(width: 8),
          const Text('Add Offer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kDark)),
          const Spacer(),
          IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: kLightGrey), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        ])),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24,20,24,0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Offer Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kPrimary)),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.bolt, size: 15), label: const Text('Extract info'),
                style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
            ]),
            const SizedBox(height: 4),
            const Text('Paste or write the full description, then click "Extract info" to auto-fill the fields below.', style: TextStyle(fontSize: 12, color: kLightGrey)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(color: Color(0xFFFAFAFA), border: Border(left: BorderSide(color: kBorder), right: BorderSide(color: kBorder), top: BorderSide(color: kBorder)), borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
              child: Wrap(spacing: 2, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
                _ToolbarBtn('B', bold: true), _ToolbarBtn('I', italic: true), _ToolbarBtn('U', underline: true),
                const _ToolbarDivider(), const _ToolbarDropdown(), const _ToolbarDivider(),
                _ToolbarIcon(Icons.format_list_bulleted), _ToolbarIcon(Icons.format_list_numbered),
                _ToolbarIcon(Icons.format_indent_decrease), _ToolbarIcon(Icons.format_indent_increase),
                const _ToolbarDivider(), _ToolbarIcon(Icons.link), _ToolbarIcon(Icons.link_off),
                const _ToolbarDivider(), _ToolbarIcon(Icons.undo), _ToolbarIcon(Icons.redo),
              ]),
            ),
            Container(
              decoration: const BoxDecoration(border: Border(left: BorderSide(color: kBorder), right: BorderSide(color: kBorder), bottom: BorderSide(color: kBorder)), borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
              child: TextField(controller: _descCtrl, maxLines: 6, decoration: const InputDecoration(hintText: 'Detailed description of the position, missions, desired profile...', hintStyle: TextStyle(color: kLightGrey, fontSize: 13), border: InputBorder.none, contentPadding: EdgeInsets.all(12)), style: const TextStyle(fontSize: 13)),
            ),
            const SizedBox(height: 14),
            const Text('short Description', style: TextStyle(fontSize: 12, color: kGrey)),
            const SizedBox(height: 4),
            _inputField(_shortDescCtrl, 'Short summary of the offer', maxLines: 3),
            const SizedBox(height: 24),
            const Text('Identification', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kPrimary)),
            const SizedBox(height: 14),
            Row(children: [Expanded(child: _labeledField('Title *', _titleCtrl, 'Job title')), const SizedBox(width: 14), Expanded(child: _labeledField('Years of experience *', _expCtrl, 'ex: 3'))]),
            const SizedBox(height: 14),
            Row(children: [Expanded(child: _labeledDropdown('Type *', kTypeOptions, _type, (v) => setState(() => _type = v))), const SizedBox(width: 14), Expanded(child: _labeledDropdown('Category *', kCategoryOptions, _category, (v) => setState(() => _category = v)))]),
            const SizedBox(height: 14),
            Row(children: [Expanded(child: _labeledDropdown('Contract *', kContractOptions, _contract, (v) => setState(() => _contract = v))), const SizedBox(width: 14), Expanded(child: _labeledMultiSelectSkills('Skills *', kSkillOptions, _skills, (s) => setState(() => _skills = s)))]),
            const SizedBox(height: 24),
            const Text('Logistics', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: kPrimary)),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Icon(Icons.location_on_outlined, size: 14, color: kGrey), SizedBox(width: 4), Text('Address *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)))]),
                const SizedBox(height: 4), _inputField(_addressCtrl, 'City or address'),
              ])),
              const SizedBox(width: 14),
              Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Icon(Icons.access_time_outlined, size: 14, color: kGrey), SizedBox(width: 4), Text('Start Date *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)))]),
                const SizedBox(height: 4), _inputField(_startDateCtrl, 'YYYY-MM-DD'),
              ])),
              const SizedBox(width: 14),
              Expanded(child: _labeledField('Duration *', _durationCtrl, 'ex: 6 mois')),
            ]),
            const SizedBox(height: 20),
            Row(children: [
              GestureDetector(
                onTap: () => setState(() => _exclusive = !_exclusive),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 42, height: 24,
                  decoration: BoxDecoration(color: _exclusive ? kPrimary : const Color(0xFFD1D5DB), borderRadius: BorderRadius.circular(12)),
                  child: AnimatedAlign(duration: const Duration(milliseconds: 200), alignment: _exclusive ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(width: 18, height: 18, margin: const EdgeInsets.symmetric(horizontal: 3), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2)]))),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Exclusive offer (Challenge)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ]),
            const SizedBox(height: 20),
          ]),
        )),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), style: OutlinedButton.styleFrom(side: const BorderSide(color: kBorder, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)), padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10)), child: const Text('Cancel', style: TextStyle(color: Color(0xFF374151), fontSize: 13))),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10), textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)), child: const Text('Submit')),
        ])),
      ]),
    ),
  );
}

// ─── TOOLBAR ─────────────────────────────────────────────────────────────────
class _ToolbarBtn extends StatelessWidget {
  final String label; final bool bold, italic, underline;
  const _ToolbarBtn(this.label, {this.bold=false, this.italic=false, this.underline=false});
  @override
  Widget build(BuildContext context) => InkWell(onTap: () {}, borderRadius: BorderRadius.circular(5),
    child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(5)),
      child: Center(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: bold ? FontWeight.w700 : FontWeight.normal, fontStyle: italic ? FontStyle.italic : FontStyle.normal, decoration: underline ? TextDecoration.underline : TextDecoration.none, color: kDark)))));
}
class _ToolbarIcon extends StatelessWidget {
  final IconData icon; const _ToolbarIcon(this.icon);
  @override
  Widget build(BuildContext context) => InkWell(onTap: () {}, borderRadius: BorderRadius.circular(5),
    child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(5)), child: Icon(icon, size: 15, color: kGrey)));
}
class _ToolbarDivider extends StatelessWidget {
  const _ToolbarDivider();
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 22, color: kBorder, margin: const EdgeInsets.symmetric(horizontal: 2));
}
class _ToolbarDropdown extends StatefulWidget {
  const _ToolbarDropdown();
  @override
  State<_ToolbarDropdown> createState() => _ToolbarDropdownState();
}
class _ToolbarDropdownState extends State<_ToolbarDropdown> {
  String _selected = 'Normal';
  @override
  Widget build(BuildContext context) => Container(
    height: 28, padding: const EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: kBorder), borderRadius: BorderRadius.circular(5)),
    child: DropdownButtonHideUnderline(child: DropdownButton<String>(
      value: _selected, isDense: true, style: const TextStyle(fontSize: 12, color: kDark),
      items: ['Small','Normal','Large','X-Large'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      onChanged: (v) => setState(() => _selected = v!),
    )),
  );
}