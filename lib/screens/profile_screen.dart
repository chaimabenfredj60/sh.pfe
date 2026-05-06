import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _primary = Color(0xFF00B4A6);
  static const Color _bgPage = Color(0xFFF4F6F9);
  static const Color _bgCard = Color(0xFFFFFFFF);
  static const Color _bgInput = Color(0xFFF0F2F5);
  static const Color _border = Color(0xFFDDE1E7);
  static const Color _labelColor = Color(0xFF6B7280);
  static const Color _textColor = Color(0xFF1F2937);
  static const Color _hintColor = Color(0xFF9CA3AF);
  static const Color _divider = Color(0xFFE5E7EB);

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _postCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _dailyRateCtrl = TextEditingController();
  final _dailyRoleCtrl = TextEditingController();
  final _summaryCtrl = TextEditingController();
  String? _selectedCategory;

  final List<Map<String, dynamic>> _domainSkills = [];
  final _domainSkillCtrl = TextEditingController();
  String _domainLevel = 'Beginner';

  final List<Map<String, dynamic>> _fonctionelSkills = [];
  final _fonctionelSkillCtrl = TextEditingController();
  String _fonctionelLevel = 'Beginner';

  final List<Map<String, dynamic>> _technicalSkills = [];
  final _technicalSkillCtrl = TextEditingController();
  String _technicalLevel = 'Beginner';

  final List<Map<String, String>> _experiences = [];
  final _expTitleCtrl = TextEditingController();
  final _expCompanyCtrl = TextEditingController();
  final _expStartCtrl = TextEditingController();
  final _expEndCtrl = TextEditingController();
  final _expDescCtrl = TextEditingController();

  final List<Map<String, String>> _educations = [];
  final _eduDegreeCtrl = TextEditingController();
  final _eduSchoolCtrl = TextEditingController();
  final _eduYearCtrl = TextEditingController();

  final List<Map<String, String>> _languages = [];
  final _langCtrl = TextEditingController();
  String _langLevel = 'Beginner';

  final List<Map<String, String>> _certifications = [];
  final _certNameCtrl = TextEditingController();
  final _certOrgCtrl = TextEditingController();
  final _certYearCtrl = TextEditingController();

  final List<Map<String, String>> _trainings = [];
  final _trainTitleCtrl = TextEditingController();
  final _trainOrgCtrl = TextEditingController();
  final _trainYearCtrl = TextEditingController();

  static const List<String> _levels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert'
  ];

  InputDecoration _inputDec(String hint, {IconData? icon}) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _hintColor, fontSize: 14),
        prefixIcon:
            icon != null ? Icon(icon, color: _hintColor, size: 20) : null,
        filled: true,
        fillColor: _bgInput,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primary, width: 1.5),
        ),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: TextStyle(
                color: _labelColor, fontSize: 13, fontWeight: FontWeight.w600)),
      );

  Widget _field(TextEditingController ctrl, String hint,
          {int maxLines = 1, TextInputType? keyboardType, IconData? icon}) =>
      TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: _textColor, fontSize: 14),
        decoration: _inputDec(hint, icon: icon),
      );

  Widget _dropdownField(
          String value, List<String> items, ValueChanged<String?> onChanged) =>
      Container(
        decoration: BoxDecoration(
          color: _bgInput,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: Colors.white,
            iconEnabledColor: _labelColor,
            style: TextStyle(color: _textColor, fontSize: 14),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );

  Widget _chip(String label, String sublabel, VoidCallback onDelete) =>
      Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _primary.withOpacity(0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: TextStyle(
                    color: _textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            if (sublabel.isNotEmpty)
              Text(sublabel,
                  style: TextStyle(color: _labelColor, fontSize: 11)),
          ]),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.close, size: 14, color: _labelColor),
          ),
        ]),
      );

  Widget _addRow(TextEditingController ctrl, String hint, String buttonLabel,
          VoidCallback onAdd) =>
      Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: _bgInput,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border),
            ),
            child: Row(children: [
              const SizedBox(width: 12),
              Icon(Icons.add, color: _hintColor, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: ctrl,
                  style: TextStyle(color: _textColor, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: _hintColor, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            elevation: 0,
          ),
          child: const Icon(Icons.add, size: 20),
        ),
      ]);

  Widget _sectionCard(String title, Widget content) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _border),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(title,
                  style: TextStyle(
                      color: _textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
            ),
            Divider(color: _divider, height: 1),
            Padding(padding: const EdgeInsets.all(16), child: content),
          ],
        ),
      );

  Widget _emptyHint(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text, style: TextStyle(color: _hintColor, fontSize: 13)),
      );

  Widget _skillsSection(
    List<Map<String, dynamic>> list,
    TextEditingController ctrl,
    String level,
    ValueChanged<String> onLevelChanged,
    VoidCallback onAdd,
    String sectionTitle,
  ) =>
      _sectionCard(
        sectionTitle,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (list.isEmpty) _emptyHint('No items added yet'),
          if (list.isNotEmpty)
            Wrap(
              children: list
                  .asMap()
                  .entries
                  .map((e) => _chip(e.value['name'], e.value['level'],
                      () => setState(() => list.removeAt(e.key))))
                  .toList(),
            ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
                child: _addRow(ctrl, 'Add new $sectionTitle', 'Add', onAdd)),
          ]),
          const SizedBox(height: 10),
          _dropdownField(level, _levels, (v) => onLevelChanged(v ?? level)),
        ]),
      );

  Widget _experiencesCard() => _sectionCard(
        'Experiences',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_experiences.isEmpty) _emptyHint('No items added yet'),
          ..._experiences.asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _border),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(e.value['title'] ?? '',
                                style: TextStyle(
                                    color: _textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                            Text(e.value['company'] ?? '',
                                style: TextStyle(
                                    color: _labelColor, fontSize: 12)),
                            Text('${e.value['start']} - ${e.value['end']}',
                                style:
                                    TextStyle(color: _hintColor, fontSize: 11)),
                            if ((e.value['desc'] ?? '').isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(e.value['desc'] ?? '',
                                    style: TextStyle(
                                        color: _textColor, fontSize: 12)),
                              ),
                          ])),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.redAccent, size: 18),
                        onPressed: () =>
                            setState(() => _experiences.removeAt(e.key)),
                      ),
                    ]),
              )),
          const SizedBox(height: 8),
          _addRow(_expTitleCtrl, 'Add new Experience', 'Add', () {
            if (_expTitleCtrl.text.isEmpty) return;
            setState(() {
              _experiences.add({
                'title': _expTitleCtrl.text,
                'company': _expCompanyCtrl.text,
                'start': _expStartCtrl.text,
                'end': _expEndCtrl.text,
                'desc': _expDescCtrl.text,
              });
              _expTitleCtrl.clear();
              _expCompanyCtrl.clear();
              _expStartCtrl.clear();
              _expEndCtrl.clear();
              _expDescCtrl.clear();
            });
          }),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('Company'),
                  _field(_expCompanyCtrl, 'Company name'),
                ])),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('Start'),
                  _field(_expStartCtrl, 'MM/YYYY'),
                ])),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('End'),
                  _field(_expEndCtrl, 'MM/YYYY'),
                ])),
          ]),
          const SizedBox(height: 10),
          _label('Description'),
          _field(_expDescCtrl, 'Describe your role...', maxLines: 3),
        ]),
      );

  Widget _educationCard() => _sectionCard(
        'Education history',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_educations.isEmpty) _emptyHint('No items added yet'),
          ..._educations.asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _border),
                ),
                child: Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(e.value['degree'] ?? '',
                            style: TextStyle(
                                color: _textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                        Text(e.value['school'] ?? '',
                            style: TextStyle(color: _labelColor, fontSize: 12)),
                        Text(e.value['year'] ?? '',
                            style: TextStyle(color: _hintColor, fontSize: 11)),
                      ])),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 18),
                    onPressed: () =>
                        setState(() => _educations.removeAt(e.key)),
                  ),
                ]),
              )),
          _addRow(_eduDegreeCtrl, 'Add new Education', 'Add', () {
            if (_eduDegreeCtrl.text.isEmpty) return;
            setState(() {
              _educations.add({
                'degree': _eduDegreeCtrl.text,
                'school': _eduSchoolCtrl.text,
                'year': _eduYearCtrl.text,
              });
              _eduDegreeCtrl.clear();
              _eduSchoolCtrl.clear();
              _eduYearCtrl.clear();
            });
          }),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('School'),
                  _field(_eduSchoolCtrl, 'Institution'),
                ])),
            const SizedBox(width: 10),
            SizedBox(
                width: 120,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Year'),
                      _field(_eduYearCtrl, 'e.g. 2021'),
                    ])),
          ]),
        ]),
      );

  Widget _languagesCard() => _sectionCard(
        'Languages',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_languages.isEmpty) _emptyHint('No items added yet'),
          if (_languages.isNotEmpty)
            Wrap(
              children: _languages
                  .asMap()
                  .entries
                  .map((e) => _chip(e.value['name']!, e.value['level']!,
                      () => setState(() => _languages.removeAt(e.key))))
                  .toList(),
            ),
          const SizedBox(height: 8),
          _addRow(_langCtrl, 'Add new Language', 'Add', () {
            if (_langCtrl.text.isEmpty) return;
            setState(() {
              _languages.add({'name': _langCtrl.text, 'level': _langLevel});
              _langCtrl.clear();
            });
          }),
          const SizedBox(height: 10),
          _dropdownField(_langLevel, _levels,
              (v) => setState(() => _langLevel = v ?? _langLevel)),
        ]),
      );

  Widget _certificationsCard() => _sectionCard(
        'Certifications',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_certifications.isEmpty) _emptyHint('No items added yet'),
          ..._certifications.asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _border),
                ),
                child: Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(e.value['name'] ?? '',
                            style: TextStyle(
                                color: _textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                        Text('${e.value['org']} - ${e.value['year']}',
                            style: TextStyle(color: _labelColor, fontSize: 12)),
                      ])),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 18),
                    onPressed: () =>
                        setState(() => _certifications.removeAt(e.key)),
                  ),
                ]),
              )),
          _addRow(_certNameCtrl, 'Add new Certification', 'Add', () {
            if (_certNameCtrl.text.isEmpty) return;
            setState(() {
              _certifications.add({
                'name': _certNameCtrl.text,
                'org': _certOrgCtrl.text,
                'year': _certYearCtrl.text,
              });
              _certNameCtrl.clear();
              _certOrgCtrl.clear();
              _certYearCtrl.clear();
            });
          }),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('Organization'),
                  _field(_certOrgCtrl, 'Issuing org'),
                ])),
            const SizedBox(width: 10),
            SizedBox(
                width: 120,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Year'),
                      _field(_certYearCtrl, 'e.g. 2023'),
                    ])),
          ]),
        ]),
      );

  Widget _trainingCard() => _sectionCard(
        'Training',
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_trainings.isEmpty) _emptyHint('No items added yet'),
          ..._trainings.asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _border),
                ),
                child: Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(e.value['title'] ?? '',
                            style: TextStyle(
                                color: _textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                        Text('${e.value['org']} - ${e.value['year']}',
                            style: TextStyle(color: _labelColor, fontSize: 12)),
                      ])),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 18),
                    onPressed: () => setState(() => _trainings.removeAt(e.key)),
                  ),
                ]),
              )),
          _addRow(_trainTitleCtrl, 'Add new Training', 'Add', () {
            if (_trainTitleCtrl.text.isEmpty) return;
            setState(() {
              _trainings.add({
                'title': _trainTitleCtrl.text,
                'org': _trainOrgCtrl.text,
                'year': _trainYearCtrl.text,
              });
              _trainTitleCtrl.clear();
              _trainOrgCtrl.clear();
              _trainYearCtrl.clear();
            });
          }),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _label('Organization'),
                  _field(_trainOrgCtrl, 'Provider'),
                ])),
            const SizedBox(width: 10),
            SizedBox(
                width: 120,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Year'),
                      _field(_trainYearCtrl, 'e.g. 2024'),
                    ])),
          ]),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) => Scaffold(
        backgroundColor: _bgPage,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(appTheme.translate('profile'),
                  style: TextStyle(
                      color: _textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),

              // Personal Info Card
              _sectionCard(
                appTheme.translate('informations'),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label(appTheme.translate('first_name')),
                          _field(_firstNameCtrl,
                              appTheme.translate('enter_first_name'),
                              icon: Icons.person_outline),
                        ])),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label(appTheme.translate('last_name')),
                          _field(_lastNameCtrl,
                              appTheme.translate('enter_last_name'),
                              icon: Icons.person_outline),
                        ])),
                  ]),
                  const SizedBox(height: 14),
                  Row(children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label('Categorie'),
                          Container(
                            decoration: BoxDecoration(
                              color: _bgInput,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _border),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                hint: Text('Select...',
                                    style: TextStyle(
                                        color: _hintColor, fontSize: 14)),
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                iconEnabledColor: _labelColor,
                                style:
                                    TextStyle(color: _textColor, fontSize: 14),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Tech', child: Text('Tech')),
                                  DropdownMenuItem(
                                      value: 'Finance', child: Text('Finance')),
                                  DropdownMenuItem(
                                      value: 'Marketing',
                                      child: Text('Marketing')),
                                ],
                                onChanged: (v) =>
                                    setState(() => _selectedCategory = v),
                              ),
                            ),
                          ),
                        ])),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label('Post'),
                          _field(_postCtrl, 'Enter position',
                              icon: Icons.work_outline),
                        ])),
                  ]),
                  const SizedBox(height: 14),
                  Row(children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label('Phone'),
                          _field(_phoneCtrl, 'Enter phone number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone),
                        ])),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _label('Email'),
                          _field(_emailCtrl, 'Enter email address',
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress),
                        ])),
                  ]),
                  const SizedBox(height: 14),
                  _label('Daily Rate'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 26,
                    child: _field(_dailyRateCtrl, 'Enter daily rate',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(height: 14),
                  _label('Daily Role'),
                  _field(_dailyRoleCtrl, 'Describe your daily role',
                      icon: Icons.description_outlined),
                  const SizedBox(height: 14),
                  _label('Summary'),
                  _field(_summaryCtrl, 'Write a brief summary',
                      icon: Icons.notes_outlined, maxLines: 4),
                ]),
              ),

              // Skills & Expertise title
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text('Skills & Expertise',
                    style: TextStyle(
                        color: _textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),

              // Skills sections
              _skillsSection(
                _domainSkills,
                _domainSkillCtrl,
                _domainLevel,
                (v) => setState(() => _domainLevel = v),
                () {
                  if (_domainSkillCtrl.text.isEmpty) return;
                  setState(() {
                    _domainSkills.add(
                        {'name': _domainSkillCtrl.text, 'level': _domainLevel});
                    _domainSkillCtrl.clear();
                  });
                },
                'Domain Skills',
              ),
              _skillsSection(
                _fonctionelSkills,
                _fonctionelSkillCtrl,
                _fonctionelLevel,
                (v) => setState(() => _fonctionelLevel = v),
                () {
                  if (_fonctionelSkillCtrl.text.isEmpty) return;
                  setState(() {
                    _fonctionelSkills.add({
                      'name': _fonctionelSkillCtrl.text,
                      'level': _fonctionelLevel
                    });
                    _fonctionelSkillCtrl.clear();
                  });
                },
                'Professional Skills',
              ),
              _skillsSection(
                _technicalSkills,
                _technicalSkillCtrl,
                _technicalLevel,
                (v) => setState(() => _technicalLevel = v),
                () {
                  if (_technicalSkillCtrl.text.isEmpty) return;
                  setState(() {
                    _technicalSkills.add({
                      'name': _technicalSkillCtrl.text,
                      'level': _technicalLevel
                    });
                    _technicalSkillCtrl.clear();
                  });
                },
                'Technical Skills',
              ),

              _experiencesCard(),
              _educationCard(),
              _languagesCard(),
              _certificationsCard(),
              _trainingCard(),

              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Profile saved successfully!'),
                        backgroundColor: _primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('SAVE PROFILE',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _postCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _dailyRateCtrl.dispose();
    _dailyRoleCtrl.dispose();
    _summaryCtrl.dispose();
    _domainSkillCtrl.dispose();
    _fonctionelSkillCtrl.dispose();
    _technicalSkillCtrl.dispose();
    _expTitleCtrl.dispose();
    _expCompanyCtrl.dispose();
    _expStartCtrl.dispose();
    _expEndCtrl.dispose();
    _expDescCtrl.dispose();
    _eduDegreeCtrl.dispose();
    _eduSchoolCtrl.dispose();
    _eduYearCtrl.dispose();
    _langCtrl.dispose();
    _certNameCtrl.dispose();
    _certOrgCtrl.dispose();
    _certYearCtrl.dispose();
    _trainTitleCtrl.dispose();
    _trainOrgCtrl.dispose();
    _trainYearCtrl.dispose();
    super.dispose();
  }
}
