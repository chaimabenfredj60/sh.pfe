import 'package:flutter/material.dart';

// ─── COLORS ──────────────────────────────────────────────────────────────────
const Color kPrimary = Color(0xFF00B4A6);
const Color kBg = Color(0xFFF5F6FA);
const Color kBorder = Color(0xFFE5E7EB);
const Color kGrey = Color(0xFF6B7280);
const Color kLightGrey = Color(0xFF9CA3AF);
const Color kDark = Color(0xFF111827);
const Color kPrimaryLight = Color(0xFFE6F9F7);
const Color kTagBg = Color(0xFFF3F4F6);

// ─── OPTIONS ─────────────────────────────────────────────────────────────────
const List<String> kTypeOptions = ['REMOTE', 'HYBRIDE', 'ON SITE'];
const List<String> kCategoryOptions = [
  'IT',
  'NETWORK',
  'TELECOM',
  'DEVELOPPEMENT',
  'DATA',
  'CYBER',
  'DEVOPS',
  'INFRA',
  'GESTION DE PROJET',
  'QA',
  'SYSTEM INFO'
];
const List<String> kContractOptions = ['CDD', 'CDI', 'FREELANCE', 'PARTTIME'];
const List<Map<String, String>> kRecentOptions = [
  {'value': 'RATE_ASC', 'label': 'RATE ↑'},
  {'value': 'RATE_DESC', 'label': 'RATE ↓'},
  {'value': 'START', 'label': 'START'},
];

// ─── MODEL ───────────────────────────────────────────────────────────────────
class Offer {
  final int id;
  final String title,
      company,
      location,
      price,
      description,
      type,
      mode,
      duration;
  final List<String> tags;
  final int extraTags, candidates;
  final bool expired;
  final String postedOn, startDate, experience, fullDescription;

  Offer({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.price,
    required this.description,
    required this.tags,
    required this.extraTags,
    required this.type,
    required this.mode,
    required this.expired,
    required this.duration,
    required this.candidates,
    this.postedOn = '',
    this.startDate = '',
    this.experience = '',
    this.fullDescription = '',
  });
}

final List<Offer> kInitialOffers = [
  Offer(
    id: 1,
    title: 'TechLead',
    company: 'SQLI',
    location: 'Paris',
    price: '1,00 €',
    description: 'Techlead',
    tags: ['Java', 'Spring', 'SpringBatch', 'Liquibase', 'SQL'],
    extraTags: 0,
    type: 'CDI',
    mode: 'HYBRIDE',
    expired: true,
    duration: '0j',
    candidates: 0,
    postedOn: '21 04 2026, 04:09 PM',
    startDate: '01/05/2026',
    experience: '5 ans',
    fullDescription:
        '"CONTEXTE DU POSTE\n\nDans un environnement de modernisation technologique et de migration vers les dernières versions Java, nous renforçons notre équipe de leads techniques.\n\nLe TechLead intervient en tant que référent technique et mentor pour garantir l\'excellence architecturale et la cohérence des projets.\n\nUne expérience solide en ecosystème Java Spring est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. LEADERSHIP TECHNIQUE\nDéfinir et imposer les standards de code\nMentor les développeurs junior et intermediate\nRealiser les revues de code\nGarantir la qualité du code\n\n2. ARCHITECTURE\nConcevoir l\'architecture applicative\nOptimiser les performances\nValider les choix technologiques\nDocumenter les décisions\n\n3. GESTION TECHNIQUE\nPiloter les jalons critiques\nGérer les risques techniques\nCoordinner les équipes\nAssurer le respect des délais"',
  ),
  Offer(
    id: 2,
    title: 'Ingénieur réseaux et sécurité',
    company: 'PORTALITE',
    location: 'La Défense',
    price: '500,00 €',
    description:
        'Contact Emagine : Sumi Delplanque Delivery Specialist Sumi.Delplanque@emagine.org +33 1 41 92 56 78',
    tags: ['Cisco ASA', 'Stormshield', 'Ansible/gitlab'],
    extraTags: 0,
    type: 'FREELANCE',
    mode: 'HYBRIDE',
    expired: false,
    duration: '25j',
    candidates: 4,
    postedOn: '20 04 2026, 10:00 AM',
    startDate: '01/06/2026',
    experience: '3 ans',
    fullDescription:
        '"CONTEXTE DU POSTE\n\nDans un environnement de renforcement des mesures de sécurité informatique, nous recrutons un expert réseaux et sécurité.\n\nL\'Ingénieur Réseaux et Sécurité intervient comme pilier de la cybersécurité et de la stabilité réseau.\n\nUne expérience sur les appliances de sécurité (Cisco ASA, Stormshield) est fortement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. ARCHITECTURE SÉCURITÉ\nConcevoir l\'architecture de sécurité réseau\nImpémenter les politiques de sécurité\nManager les pare-feu\nAssurer la conformité réglementaire\n\n2. ADMINISTRATION RÉSEAU\nOptimiser la performance réseau\nDéployer l\'infrastructure\nGérer les accès VPN\nDépanner les problèmes réseau\n\n3. AUDIT ET CONFORMITÉ\nRealiser des audits de sécurité\nDocumenter les configurations\nParticiper aux tests de pénétration\nGérer les vulnérabilités"',
  ),
  Offer(
    id: 3,
    title: 'Business Analyst Data Assurance',
    company: 'SQLI',
    location: 'Paris',
    price: '500,00 €',
    description:
        "Interface entre métiers de l'assurance vie et équipes IT/Data pour garantir cohérence, qualité et valorisation des données métier dans un contexte de transformation digitale.",
    tags: ['Business Analysis', 'Data Modeling', 'ASSURANCE VIE'],
    extraTags: 7,
    type: 'CDI',
    mode: 'HYBRIDE',
    expired: false,
    duration: 'LONGUE',
    candidates: 0,
    postedOn: '21 04 2026, 04:09 PM',
    startDate: '01/05/2026',
    experience: '5 ans',
    fullDescription:
        '"CONTEXTE DU POSTE\n\nDans un contexte de transformation, de modernisation des systèmes d\'information et de renforcement des exigences réglementaires, l\'entreprise renforce ses équipes Data.\n\nLe/la Business Analyst Data Assurance intervient comme interface entre les métiers de l\'assurance vie et les équipes IT/Data.\n\nUne expérience dans les secteurs de l\'assurance vie, banque ou finance est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. ANALYSE DES BESOINS MÉTIER\nRecueillir et analyser les besoins\nAnimer des ateliers de cadrage\nComprendre les enjeux du secteur\nFormaliser en user stories\n\n2. MODÉLISATION DES DONNÉES\nConcevoir les modèles de données\nModéliser les entités clés\nDéfinir les règles de gestion\nGarantir la cohérence\n\n3. INTERFACE IT/DATA\nTraduire les besoins en exigences\nParticiper aux flux ETL/ELT\nContribuer à la conception data\n\n4. RECETTE ET QUALITÉ\nDéfinir les cas de test\nParticiper aux phases UAT\nVérifier les données\nIdentifier les anomalies"',
  ),
  Offer(
    id: 4,
    title: 'Ingénieur DevOps AWS',
    company: 'PORTALITE',
    location: 'Saint Quentin',
    price: '550,00 €',
    description: 'Infra cloud AWS Kubernetes Terraform.',
    tags: ['DEVOPS', 'CLOUD'],
    extraTags: 10,
    type: 'FREELANCE',
    mode: 'HYBRIDE',
    expired: false,
    duration: '10j',
    candidates: 1,
    postedOn: '20 04 2026, 10:00 AM',
    startDate: '01/06/2026',
    experience: '3 ans',
    fullDescription:
        '"CONTEXTE DU POSTE\n\nDans un contexte de migration cloud et d\'automatisation des infrastructures, nous recrutons un Ingénieur DevOps AWS.\n\nL\'Ingénieur DevOps AWS intervient pour moderniser nos processus de déploiement et garantir la scalabilité.\n\nUne expérience solide avec AWS, Kubernetes et Terraform est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. INFRASTRUCTURE CLOUD AWS\nConcevoir l\'infrastructure cloud AWS\nGérer les services EC2, RDS, S3\nOptimiser les coûts\nAssurer la haute disponibilité\n\n2. ORCHESTRATION KUBERNETES\nDéployer les clusters Kubernetes\nConfigurer les ressources\nGérer l\'autoscaling\nMonitorer la santé\n\n3. INFRASTRUCTURE AS CODE\nCréer l\'infrastructure via Terraform\nVersioner l\'IaC\nAutomatiser les déploiements\nGarantir la reproductibilité\n\n4. INTÉGRATION CONTINUE\nMettre en place les pipelines CI/CD\nAutomatiser les tests\nGérer les releases\nMonitorer les applications"',
  ),
  Offer(
    id: 5,
    title: 'Développeur Full Stack React/Node',
    company: 'TECHCORP',
    location: 'Lyon',
    price: '480,00 €',
    description:
        "Développement d'applications web modernes avec React et Node.js.",
    tags: ['DEVELOPPEMENT', 'REACT'],
    extraTags: 3,
    type: 'CDI',
    mode: 'REMOTE',
    expired: false,
    duration: '5j',
    candidates: 4,
    postedOn: '19 04 2026, 09:00 AM',
    startDate: '15/05/2026',
    experience: '2 ans',
    fullDescription:
        '"CONTEXTE DU POSTE\n\nDans un environnement de développement d\'applications web innovantes, nous renforçons notre équipe Full Stack.\n\nLe Développeur Full Stack React/Node intervient sur l\'ensemble de la stack, du frontend au backend.\n\nUne expérience avec React, Node.js et les architectures modernes est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. DÉVELOPPEMENT FRONTEND\nCréer des interfaces React\nImpémenter les designs\nOptimiser les performances\nGérer l\'état de l\'application\n\n2. DÉVELOPPEMENT BACKEND\nCréer les APIs REST Node.js\nGérer les bases de données\nImpémenter l\'authentification\nOptimiser les performances\n\n3. INTÉGRATION\nIntégrer frontend et backend\nDéployer les applications\nGérer les versions\nAssurer la compatibilité\n\n4. TESTS ET QUALITÉ\nEcrire les tests unitaires\nRealiser les revues\nDéboguer et corriger\nDocumenter le code"',
  ),
  Offer(
      id: 6,
      title: 'Architecte Cloud Azure',
      company: 'MICROSOFT CONSULTING',
      location: 'Toulouse',
      price: '650,00 €',
      description:
          'Conception et déploiement d\'architectures cloud Azure enterprise.',
      tags: ['AZURE', 'CLOUD', 'ARCHITECTURE'],
      extraTags: 5,
      type: 'FREELANCE',
      mode: 'HYBRIDE',
      expired: false,
      duration: '20j',
      candidates: 2,
      postedOn: '16 04 2026, 02:00 PM',
      startDate: '15/06/2026',
      experience: '7 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un contexte de transformation digitale et de migration cloud massive, nous recrutons un Architecte Cloud Azure.\n\nL\'Architecte Cloud intervient comme expert stratégique pour concevoir des architectures cloud scalables et conformes.\n\nUne expérience solide avec Azure, les patterns cloud et la gouvernance IT est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. CONCEPTION ARCHITECTURALE\nConccevoir les architectures cloud\nProposer les patterns Azure\nAssurer la scalabilité\nDocumenter les décisions\n\n2. MIGRATION CLOUD\nPiloter les migrations Azure\nOptimiser les coûts\nAssurer la continuité\nGérer les risques\n\n3. SÉCURITÉ ET CONFORMITÉ\nImpémenter la sécurité cloud\nGérer les identités IAM\nAssurer la conformité\nAuditer les environnements\n\n4. OPTIMISATION\nOptimiser les coûts\nMonitorer les performances\nFaire des recommendations\nGérer la gouvernance"'),
  Offer(
      id: 7,
      title: 'QA Engineer Automation',
      company: 'TESTFORGE',
      location: 'Nantes',
      price: '420,00 €',
      description:
          'Automatisation des tests et contrôle qualité avec Selenium et Cypress.',
      tags: ['QA', 'AUTOMATION', 'TESTING'],
      extraTags: 2,
      type: 'CDI',
      mode: 'ON SITE',
      expired: false,
      duration: '8j',
      candidates: 6,
      postedOn: '15 04 2026, 11:30 AM',
      startDate: '20/05/2026',
      experience: '4 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un environnement de transformation qualité et d\'automatisation des tests, nous recrutons un QA Engineer.\n\nLe QA Engineer Automation intervient pour garantir la qualité des applications via l\'automatisation.\n\nUne expérience avec Selenium, Cypress et les méthodologies Agile est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. STRATÉGIE DE TEST\nDéfinir les stratégies de test\nIdentifier les risques\nPrioritiser les scénarios\nAssurer la traçabilité\n\n2. AUTOMATISATION\nAutomatiser avec Selenium\nAutomatiser avec Cypress\nMaintenir les suites\nParticiper aux tests performance\n\n3. CONTRÔLE QUALITÉ\nRealiser les tests manuels\nIdentifier les défauts\nTracker les corrections\nAssurer la couverture\n\n4. GESTION QUALITÉ\nSetup les environnements\nCréer les données de test\nAmélioration continue\nCoopération équipes"'),
  Offer(
      id: 8,
      title: 'Spécialiste Cybersécurité',
      company: 'SECURIT CORP',
      location: 'Paris',
      price: '700,00 €',
      description:
          'Expert en sécurité des systèmes d\'information et audit de conformité.',
      tags: ['CYBER', 'SECURITE', 'AUDIT'],
      extraTags: 4,
      type: 'FREELANCE',
      mode: 'HYBRIDE',
      expired: false,
      duration: '30j',
      candidates: 1,
      postedOn: '14 04 2026, 03:15 PM',
      startDate: '01/07/2026',
      experience: '8 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un contexte de renforcement des mesures de sécurité informatique et de conformité réglementaire, nous recrutons un Spécialiste Cybersécurité.\n\nLe Spécialiste intervient en tant qu\'expert pour sécuriser l\'infrastructure IT et protéger les données.\n\nUne expérience dans les audits de sécurité, l\'analyse de risques et la conformité est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. AUDIT DE SÉCURITÉ\nRealiser les audits complets\nIdentifier les vulnérabilités\nProposer la remédiation\nDocumenter les findings\n\n2. GESTION DES RISQUES\nEvaluer les risques\nProposer les mesures\nGérer les incidents\nAssurer la continuité\n\n3. CONFORMITÉ\nAssurer ISO 27001 et GDPR\nGérer les audits\nDocumenter les politiques\nGestion de conformité\n\n4. SENSIBILISATION\nAnimer les formations\nConcevoir les plans\nGérer les incidents users\nCommuniquer les pratiques"'),
  Offer(
      id: 9,
      title: 'Ingénieur Infra Terraform',
      company: 'INFRADEV',
      location: 'Rennes',
      price: '580,00 €',
      description:
          'Infrastructure as Code avec Terraform et Ansible pour automatisation.',
      tags: ['INFRA', 'TERRAFORM', 'DEVOPS'],
      extraTags: 1,
      type: 'CDI',
      mode: 'HYBRIDE',
      expired: false,
      duration: '12j',
      candidates: 3,
      postedOn: '13 04 2026, 10:45 AM',
      startDate: '10/05/2026',
      experience: '5 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un environnement de modernisation des infrastructures et d\'automatisation, nous recrutons un Ingénieur Infrastructure Terraform.\n\nL\'Ingénieur Infra intervient pour automatiser le provisioning d\'infrastructure et garantir la reproductibilité.\n\nUne expérience solide avec Terraform, Ansible et Linux/Unix est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. INFRASTRUCTURE AS CODE\nCréer l\'infrastructure Terraform\nVersioner l\'IaC\nAutomatiser le provisioning\nGarantir la reproductibilité\n\n2. CONFIGURATION MANAGEMENT\nImpémenter Ansible\nConfigurer les serveurs\nGérer les configurations\nAssurer la conformité\n\n3. GESTION CLOUD\nDéployer l\'infrastructure\nOptimiser les coûts\nAssurer la disponibilité\nGérer la scalabilité\n\n4. MONITORING\nMaintenir l\'infrastructure\nMonitorer les performances\nGérer les mises à jour\nDocumenter"'),
  Offer(
      id: 10,
      title: 'Data Scientist ML/Python',
      company: 'AITECH LABS',
      location: 'Grenoble',
      price: '620,00 €',
      description:
          'Développement de modèles Machine Learning et analyse de données avec Python.',
      tags: ['DATA SCIENCE', 'PYTHON', 'ML'],
      extraTags: 3,
      type: 'CDI',
      mode: 'REMOTE',
      expired: false,
      duration: '14j',
      candidates: 5,
      postedOn: '12 04 2026, 08:20 AM',
      startDate: '25/05/2026',
      experience: '6 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un contexte de développement de solutions IA et d\'analyse de données avancée, nous recrutons un Data Scientist.\n\nLe Data Scientist intervient pour créer des modèles ML en production et fournir des insights actionnables.\n\nUne expérience solide avec Python, TensorFlow/PyTorch et les méthodologies ML est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. DÉVELOPPEMENT MODÈLES ML\nCréer les modèles Machine Learning\nOptimiser les hyperparamètres\nDéployer en production\nMonitorer et améliorer\n\n2. ANALYSE DE DONNÉES\nRealiser l\'exploration\nNetttoyer les données\nIdentifier les patterns\nCréer les visualisations\n\n3. BIG DATA\nGérer les grands volumes\nUtiliser Spark et Hadoop\nOptimiser les pipelines\nAutomatiser les traitements\n\n4. COLLABORATION\nTravailler avec métier\nDocumenter les modèles\nExplainer les résultats\nStratégie data"'),
  Offer(
      id: 11,
      title: 'Développeur Mobile Flutter',
      company: 'MOBDEV',
      location: 'Bordeaux',
      price: '510,00 €',
      description:
          'Développement d\'applications mobiles multi-plateformes avec Flutter.',
      tags: ['FLUTTER', 'MOBILE', 'DART'],
      extraTags: 2,
      type: 'CDI',
      mode: 'HYBRIDE',
      expired: false,
      duration: '9j',
      candidates: 3,
      postedOn: '11 04 2026, 02:30 PM',
      startDate: '20/05/2026',
      experience: '4 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un environnement de développement d\'applications mobiles multiplateformes, nous recrutons un Développeur Mobile Flutter.\n\nLe Développeur Flutter intervient pour créer des applications iOS et Android performantes à partir d\'une unique base de code.\n\nUne expérience avec Flutter, Dart, Firebase et les APIs REST est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. DÉVELOPPEMENT FLUTTER\nCréer les applications Flutter\nImpémenter l\'interface utilisateur\nGérer l\'état de l\'application\nOptimiser les performances\n\n2. INTÉGRATION BACKEND\nIntégrer les APIs REST\nGérer l\'authentification\nImpémenter le mode offline\nGérer la synchronisation\n\n3. SERVICES MOBILES\nIntégrer Firebase\nGérer les notifications push\nImpémenter l\'analytics\nGérer la sécurité\n\n4. TESTS ET DÉPLOIEMENT\nEcrire les tests\nDéboguer et optimiser\nDéployer sur stores\nGérer les versions"'),
  Offer(
      id: 12,
      title: 'Administrateur Système Linux',
      company: 'SYSTEMCORE',
      location: 'Strasbourg',
      price: '490,00 €',
      description:
          'Administration et maintenance de serveurs Linux en environnement production.',
      tags: ['LINUX', 'ADMIN SYSTEM', 'DEVOPS'],
      extraTags: 1,
      type: 'CDI',
      mode: 'ON SITE',
      expired: false,
      duration: '6j',
      candidates: 2,
      postedOn: '10 04 2026, 11:00 AM',
      startDate: '01/06/2026',
      experience: '5 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un environnement de modernisation des infrastructures et de containerisation, nous recrutons un Administrateur Système Linux.\n\nL\'Administrateur Système intervient pour gérer, maintenir et sécuriser l\'infrastructure serveurs Linux en production.\n\nUne expérience avec Docker, Kubernetes et les outils DevOps est fortement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. ADMINISTRATION SERVEURS\nGérer les serveurs Linux\nDéployer les applications\nGérer les utilisateurs\nMonitorer les ressources\n\n2. SAUVEGARDE\nImplementer les sauvegardes\nGérer restaurations\nTester la récupération\nGarantir la disponibilité\n\n3. SÉCURITÉ\nConfigurer les pare-feu\nGérer les certificats\nAuditer la sécurité\nPatcher les systèmes\n\n4. CONTAINERISATION\nDéployer Docker\nDéployer Kubernetes\nGérer les conteneurs\nMonitorer les apps"'),
  Offer(
      id: 13,
      title: 'Consultant SAP',
      company: 'ERPSOLUTIONS',
      location: 'Lyon',
      price: '680,00 €',
      description:
          'Implémentation et optimisation de solutions SAP pour clients enterprise.',
      tags: ['SAP', 'CONSULTING', 'ERP'],
      extraTags: 6,
      type: 'FREELANCE',
      mode: 'HYBRIDE',
      expired: false,
      duration: '25j',
      candidates: 1,
      postedOn: '09 04 2026, 09:45 AM',
      startDate: '10/06/2026',
      experience: '8 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un contexte de transformation digitale et d\'implémentation SAP, nous recrutons un Consultant SAP expert.\n\nLe Consultant SAP intervient pour accompagner les clients dans leurs projets de modernisation et d\'optimisation IT.\n\nUne expérience solide en SAP S/4HANA, modules FI/CO ou MM et change management est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. IMPLÉMENTATION SAP\nPiloter les projets\nConfigurer les modules\nOptimiser les processus\nAssurer la qualité\n\n2. CHANGE MANAGEMENT\nGérer le changement\nAnimer les formations\nDocumenter les processus\nAssurer l\'adoption\n\n3. OPTIMISATION\nIdentifier les opportunités\nProposer les améliorations\nOptimiser les coûts\nAméliorer la performance\n\n4. SUPPORT CLIENTS\nAccompagner les clients\nFournir des conseils\nRésoudre les problèmes\nAssurer la satisfaction"'),
  Offer(
      id: 14,
      title: 'Développeur Backend Java Spring',
      company: 'CODEFORGE',
      location: 'Lille',
      price: '560,00 €',
      description:
          'Développement de services backend scalables avec Java et Spring Boot.',
      tags: ['JAVA', 'SPRING BOOT', 'MICROSERVICES'],
      extraTags: 4,
      type: 'CDI',
      mode: 'REMOTE',
      expired: false,
      duration: '7j',
      candidates: 5,
      postedOn: '08 04 2026, 03:20 PM',
      startDate: '12/05/2026',
      experience: '5 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un environnement d\'architecture microservices et de modernisation technologique, nous recrutons un Développeur Backend Java senior.\n\nLe Développeur Backend Java intervient pour créer des services scalables et performants, en suivant les meilleures pratiques.\n\nUne expérience solide en Spring Boot, microservices et Docker est requise."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. DÉVELOPPEMENT BACKEND\nDévelopper les services Spring Boot\nCréer les APIs REST\nImpémenter la logique métier\nAssurer la qualité\n\n2. ARCHITECTURE MICROSERVICES\nConccevoir les architectures\nImpémenter les patterns\nGérer les dépendances\nAssurer la scalabilité\n\n3. PERSISTANCE DE DONNÉES\nConcevoir les schémas\nUtiliser JPA/Hibernate\nOptimiser les requêtes\nGérer les migrations\n\n4. CONTAINERISATION ET TESTS\nUtiliser Docker\nEcrire les tests unitaires\nAutomatiser les tests\nRevues de code"'),
  Offer(
      id: 15,
      title: 'Chef de Projet Digital',
      company: 'INNOVTECH',
      location: 'Nantes',
      price: '540,00 €',
      description:
          'Pilotage de projets digitaux et transformation dans un environnement agile.',
      tags: ['GESTION DE PROJET', 'AGILE', 'SCRUM'],
      extraTags: 0,
      type: 'CDI',
      mode: 'HYBRIDE',
      expired: false,
      duration: '11j',
      candidates: 4,
      postedOn: '07 04 2026, 01:10 PM',
      startDate: '05/06/2026',
      experience: '6 ans',
      fullDescription:
          '"CONTEXTE DU POSTE\n\nDans un contexte de transformation digitale et d\'initiatives innovantes, nous recrutons un Chef de Projet Digital.\n\nLe Chef de Projet Digital intervient pour piloter nos projets digitaux et assurer leur succès en environnement Agile.\n\nUne expérience en gestion de projet agile, Scrum et transformation digitale est vivement recommandée."\n\n"RESPONSABILITÉS PRINCIPALES\n\n1. PILOTAGE DE PROJETS\nDéfinir la vision et objectifs\nPlanifier les livrables\nGérer les risques\nRespect budgets et délais\n\n2. GESTION AGILE\nAnimer les cérémonies Scrum\nGérer le backlog\nAssurer la qualité\nAdapter la méthodologie\n\n3. COORDINATION D\'ÉQUIPES\nCoordinner les équipes\nCommuniquer avec stakeholders\nGérer les conflits\nMotiver les équipes\n\n4. TRANSFORMATION\nPiloter les initiatives\nGérer le changement\nCommuniquer la vision\nAssurer l\'adoption"'),
];

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
class OfferListScreen extends StatefulWidget {
  final void Function(dynamic offer)? onOfferTap;
  final String activeSubItem;
  final bool isDarkMode;
  final String language;

  const OfferListScreen({
    super.key,
    this.onOfferTap,
    this.activeSubItem = 'Liste des offres',
    this.isDarkMode = false,
    this.language = 'en',
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
  Offer? _detailOffer;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  double _extractPrice(String price) =>
      double.tryParse(price.replaceAll('€', '').replaceAll(',', '.').trim()) ??
      0;

  List<Offer> get _filtered {
    List<Offer> list = List.from(_offers);
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      list = list
          .where((o) =>
              o.title.toLowerCase().contains(q) ||
              o.company.toLowerCase().contains(q) ||
              o.location.toLowerCase().contains(q))
          .toList();
    }
    if (_selectedType != null)
      list = list.where((o) => o.mode == _selectedType).toList();
    if (_selectedContract != null)
      list = list.where((o) => o.type == _selectedContract).toList();
    if (_selectedCategory != null)
      list = list.where((o) => o.tags.contains(_selectedCategory)).toList();
    if (_selectedRecent == 'RATE_ASC')
      list.sort(
          (a, b) => _extractPrice(a.price).compareTo(_extractPrice(b.price)));
    if (_selectedRecent == 'RATE_DESC')
      list.sort(
          (a, b) => _extractPrice(b.price).compareTo(_extractPrice(a.price)));
    return list;
  }

  void _openAddOffer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, ctrl) => _AddOfferSheet(
          scrollController: ctrl,
          onSubmit: (offer) => setState(() {
            _offers.add(offer);
            _myOffers.add(offer);
          }),
        ),
      ),
    );
  }

  void _openDetail(Offer offer) => setState(() => _detailOffer = offer);
  void _closeDetail() => setState(() => _detailOffer = null);

  @override
  Widget build(BuildContext context) {
    if (_detailOffer != null) {
      return OfferDetailScreen(offer: _detailOffer!, onBack: _closeDetail);
    }

    final filtered = _filtered;
    final cdiCount = _offers.where((o) => o.type == 'CDI').length;
    final freelanceCount = _offers.where((o) => o.type == 'FREELANCE').length;

    if (widget.activeSubItem == 'Mes offres') {
      return _buildMyOffersView();
    }

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _MobileTopBar(onAddTap: _openAddOffer),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Liste des offres',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kDark)),
                    const SizedBox(height: 14),

                    // Stat cards — stacked vertically on mobile
                    _MobileStatCard(
                        icon: Icons.work_outline,
                        count: _offers.length,
                        label: 'Available offers'),
                    const SizedBox(height: 10),
                    _MobileStatCard(
                        icon: Icons.work_history_outlined,
                        count: cdiCount,
                        label: 'CDI'),
                    const SizedBox(height: 10),
                    _MobileStatCard(
                        icon: Icons.person_outline,
                        count: freelanceCount,
                        label: 'FREELANCE'),
                    const SizedBox(height: 16),

                    // Search
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _search = v),
                      decoration: _searchDecoration('Search...'),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),

                    // Filters — full width dropdowns
                    _MobileFilterDropdown(
                      label: 'Type',
                      options: kTypeOptions,
                      value: _selectedType,
                      onChange: (v) => setState(() => _selectedType = v),
                    ),
                    const SizedBox(height: 8),
                    _MobileFilterDropdown(
                      label: 'Category',
                      options: kCategoryOptions,
                      value: _selectedCategory,
                      onChange: (v) => setState(() => _selectedCategory = v),
                    ),
                    const SizedBox(height: 8),
                    _MobileFilterDropdown(
                      label: 'Contract',
                      options: kContractOptions,
                      value: _selectedContract,
                      onChange: (v) => setState(() => _selectedContract = v),
                    ),
                    const SizedBox(height: 8),
                    _MobileFilterDropdown(
                      label: 'Recent',
                      options: kRecentOptions.map((e) => e['value']!).toList(),
                      labels: kRecentOptions.map((e) => e['label']!).toList(),
                      value: _selectedRecent,
                      onChange: (v) => setState(() => _selectedRecent = v),
                    ),
                    const SizedBox(height: 10),

                    // Action buttons row
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.tune, size: 15),
                            label: const Text('Filter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _openAddOffer,
                            icon: const Icon(Icons.add, size: 15),
                            label: const Text('Add Offer'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kPrimary,
                              side:
                                  const BorderSide(color: kPrimary, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Text('${filtered.length} result(s)',
                        style: const TextStyle(
                            fontSize: 13,
                            color: kGrey,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),

                    if (filtered.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text('No offers match your filters.',
                                style: TextStyle(
                                    color: kLightGrey, fontSize: 15))),
                      )
                    else
                      ...filtered.map((o) => GestureDetector(
                            onTap: () => _openDetail(o),
                            child: _MobileOfferCard(offer: o),
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyOffersView() {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _MobileTopBar(onAddTap: _openAddOffer),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mes offres',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kDark)),
                    const SizedBox(height: 14),
                    _MobileStatCard(
                        icon: Icons.work_outline,
                        count: _myOffers.length,
                        label: 'My Offers'),
                    const SizedBox(height: 10),
                    _MobileStatCard(
                        icon: Icons.check_circle_outline,
                        count: 0,
                        label: 'Active'),
                    const SizedBox(height: 10),
                    _MobileStatCard(
                        icon: Icons.schedule_outlined,
                        count: 0,
                        label: 'Pending'),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _search = v),
                      decoration: _searchDecoration(
                          'Search by title, skill, company...'),
                    ),
                    const SizedBox(height: 24),
                    if (_myOffers.isEmpty)
                      Center(
                        child: Column(children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                                color: kPrimaryLight, shape: BoxShape.circle),
                            child: const Icon(Icons.work_outline,
                                size: 36, color: kPrimary),
                          ),
                          const SizedBox(height: 16),
                          const Text('No offers',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kDark)),
                          const SizedBox(height: 8),
                          const Text(
                              "You don't have any associated offers yet.",
                              style:
                                  TextStyle(fontSize: 14, color: kLightGrey)),
                        ]),
                      )
                    else
                      ..._myOffers.map((o) => GestureDetector(
                            onTap: () => _openDetail(o),
                            child: _MobileOfferCard(offer: o),
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _searchDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kLightGrey, fontSize: 13),
        prefixIcon: const Icon(Icons.search, color: kLightGrey, size: 18),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kBorder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kPrimary)),
        filled: true,
        fillColor: Colors.white,
      );
}

// ─── MOBILE TOP BAR ──────────────────────────────────────────────────────────
class _MobileTopBar extends StatelessWidget {
  final VoidCallback onAddTap;
  const _MobileTopBar({required this.onAddTap});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: const SizedBox.shrink(),
      );
}

// ─── MOBILE STAT CARD ────────────────────────────────────────────────────────
class _MobileStatCard extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  const _MobileStatCard(
      {required this.icon, required this.count, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 1))
          ],
        ),
        child: Row(children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: kPrimaryLight, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: kPrimary, size: 20),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$count',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700, color: kDark)),
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: kLightGrey,
                    fontWeight: FontWeight.w500)),
          ]),
        ]),
      );
}

// ─── MOBILE FILTER DROPDOWN ──────────────────────────────────────────────────
class _MobileFilterDropdown extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String>? labels;
  final String? value;
  final void Function(String?) onChange;

  const _MobileFilterDropdown({
    required this.label,
    required this.options,
    this.labels,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final active = value != null;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active ? kPrimary : kBorder, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
          isExpanded: true,
          icon: value != null
              ? GestureDetector(
                  onTap: () => onChange(null),
                  child: const Icon(Icons.close, size: 16, color: kLightGrey),
                )
              : const Icon(Icons.keyboard_arrow_down,
                  size: 18, color: kLightGrey),
          style: const TextStyle(
              fontSize: 14, color: kDark, fontWeight: FontWeight.w500),
          dropdownColor: Colors.white,
          items: options.asMap().entries.map((e) {
            final lbl = labels != null ? labels![e.key] : e.value;
            return DropdownMenuItem<String>(
              value: e.value,
              child: Text(lbl,
                  style: TextStyle(
                    fontSize: 14,
                    color: value == e.value ? kPrimary : kDark,
                    fontWeight:
                        value == e.value ? FontWeight.w600 : FontWeight.normal,
                  )),
            );
          }).toList(),
          onChanged: onChange,
        ),
      ),
    );
  }
}

// ─── MOBILE OFFER CARD ───────────────────────────────────────────────────────
class _MobileOfferCard extends StatelessWidget {
  final Offer offer;
  const _MobileOfferCard({required this.offer});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 1))
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Company icon placeholder
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: kPrimaryLight,
                    borderRadius: BorderRadius.circular(10)),
                child:
                    const Icon(Icons.work_outline, color: kPrimary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(offer.title,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: kDark)),
                        ),
                        const SizedBox(width: 6),
                        _PriceBadge(offer.price),
                      ]),
                      const SizedBox(height: 2),
                      Row(children: [
                        Text(offer.company,
                            style: const TextStyle(fontSize: 12, color: kGrey)),
                        const SizedBox(width: 4),
                        const Icon(Icons.circle, size: 3, color: kLightGrey),
                        const SizedBox(width: 4),
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: kLightGrey),
                        const SizedBox(width: 2),
                        Expanded(
                            child: Text(offer.location,
                                style:
                                    const TextStyle(fontSize: 12, color: kGrey),
                                overflow: TextOverflow.ellipsis)),
                      ]),
                    ]),
              ),
            ]),
          ),

          // Description
          if (offer.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Text(offer.description,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF4B5563), height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
            ),

          // Tags
          if (offer.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Wrap(spacing: 6, runSpacing: 6, children: [
                ...offer.tags
                    .take(3)
                    .map((t) => _MobileTagChip(t, color: _tagColor(t))),
                if (offer.extraTags > 0)
                  _MobileTagChip('+${offer.extraTags}', dim: true),
              ]),
            ),

          // Bottom meta row
          Container(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
            ),
            child: Row(children: [
              _MetaBadge(offer.type, bg: kPrimaryLight, fg: kPrimary),
              const SizedBox(width: 6),
              _MetaBadge(offer.mode, bg: kTagBg, fg: kGrey),
              if (offer.expired) ...[
                const SizedBox(width: 6),
                _MetaBadge('Expired',
                    bg: const Color(0xFFFEE2E2), fg: const Color(0xFFDC2626)),
              ],
              const Spacer(),
              if (!offer.expired) ...[
                const Icon(Icons.access_time, size: 12, color: kLightGrey),
                const SizedBox(width: 3),
                Text(offer.duration,
                    style: const TextStyle(fontSize: 11, color: kLightGrey)),
                const SizedBox(width: 10),
              ],
              const Icon(Icons.person_outline, size: 12, color: kLightGrey),
              const SizedBox(width: 3),
              Text('${offer.candidates}',
                  style: const TextStyle(fontSize: 11, color: kLightGrey)),
            ]),
          ),
        ]),
      );

  Color _tagColor(String tag) {
    final lower = tag.toLowerCase();
    if (lower.contains('java') ||
        lower.contains('spring') ||
        lower.contains('sql')) return const Color(0xFF3B82F6);
    if (lower.contains('cisco') ||
        lower.contains('ansible') ||
        lower.contains('storm')) return const Color(0xFF8B5CF6);
    if (lower.contains('business') || lower.contains('data')) return kPrimary;
    return kGrey;
  }
}

class _PriceBadge extends StatelessWidget {
  final String price;
  const _PriceBadge(this.price);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: kPrimaryLight, borderRadius: BorderRadius.circular(8)),
        child: Text(price,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: kPrimary)),
      );
}

class _MobileTagChip extends StatelessWidget {
  final String label;
  final bool dim;
  final Color color;
  const _MobileTagChip(this.label, {this.dim = false, this.color = kGrey});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: dim ? kTagBg : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: dim ? kBorder : color.withOpacity(0.3)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: dim ? kLightGrey : color)),
      );
}

class _MetaBadge extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const _MetaBadge(this.label, {required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// OFFER DETAIL SCREEN — Mobile
// ═══════════════════════════════════════════════════════════════════════════════
class OfferDetailScreen extends StatefulWidget {
  final Offer offer;
  final VoidCallback onBack;
  const OfferDetailScreen(
      {super.key, required this.offer, required this.onBack});

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  void _openAddCV() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _CooptBottomSheet(offer: widget.offer),
      ),
    );
  }

  void _openApplyToOffer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, ctrl) =>
            _ApplyBottomSheet(offer: widget.offer, scrollController: ctrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(children: [
                IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back, color: kGrey)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.description_outlined, size: 13),
                        label: const Text('Request a document'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                        ),
                      ),
                      const SizedBox(width: 6),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.folder_outlined, size: 13),
                        label: const Text('My documents'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kPrimary,
                          side: const BorderSide(color: kPrimary, width: 1.5),
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.notifications_none, color: kGrey),
                const SizedBox(width: 8),
              ]),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mini stat cards — 2 per row
                      Row(children: [
                        Expanded(
                            child: _MiniStatCard(
                                icon: Icons.star_border,
                                iconColor: Colors.amber,
                                count: 0,
                                label: 'Applications')),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _MiniStatCard(
                                icon: Icons.check_circle_outline,
                                iconColor: kPrimary,
                                count: 0,
                                label: 'Accepted')),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                            child: _MiniStatCard(
                                icon: Icons.share_outlined,
                                iconColor: Colors.orange,
                                count: 0,
                                label: 'Shares')),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _MiniStatCardScore(
                                icon: Icons.emoji_events_outlined,
                                iconColor: Colors.purple,
                                score: '25%',
                                label: 'Avg. Score')),
                      ]),
                      const SizedBox(height: 14),

                      // Main offer card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF3F4F6)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          child: Text(offer.title,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: kDark)),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Text('SHARED',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ]),
                                      const SizedBox(height: 10),
                                      Wrap(
                                          spacing: 6,
                                          runSpacing: 6,
                                          children: [
                                            _DetailBadge(offer.company,
                                                bg: kPrimaryLight,
                                                fg: kPrimary),
                                            _DetailBadge(offer.location,
                                                icon:
                                                    Icons.location_on_outlined,
                                                bg: kTagBg,
                                                fg: kGrey),
                                            _DetailBadge(offer.type,
                                                bg: const Color(0xFFDCFCE7),
                                                fg: const Color(0xFF16A34A)),
                                            _DetailBadge(offer.mode,
                                                bg: const Color(0xFFFFF7ED),
                                                fg: const Color(0xFFEA580C)),
                                          ]),
                                    ]),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF3F4F6)),

                              // Meta grid
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(children: [
                                    Expanded(
                                        child: _MetaItem(
                                            icon: Icons.calendar_today_outlined,
                                            label: 'Posted on',
                                            value: offer.postedOn.isNotEmpty
                                                ? offer.postedOn
                                                : '21 04 2026')),
                                    Expanded(
                                        child: _MetaItem(
                                            icon: Icons.work_outline,
                                            label: 'Start',
                                            value: offer.startDate.isNotEmpty
                                                ? offer.startDate
                                                : '01/05/2026')),
                                  ]),
                                  const SizedBox(height: 14),
                                  Row(children: [
                                    Expanded(
                                        child: _MetaItem(
                                            icon: Icons.check_circle_outline,
                                            label: 'Experience',
                                            value: offer.experience.isNotEmpty
                                                ? offer.experience
                                                : '5 ans')),
                                    Expanded(
                                        child: _MetaItem(
                                            icon: Icons.card_giftcard_outlined,
                                            label: 'Daily Rate',
                                            value: offer.price)),
                                  ]),
                                  const SizedBox(height: 14),
                                  Row(children: [
                                    Expanded(
                                        child: _MetaItem(
                                            icon: Icons.timelapse_outlined,
                                            label: 'Duration',
                                            value: offer.duration)),
                                    const Expanded(child: SizedBox()),
                                  ]),
                                ]),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF3F4F6)),

                              // Tags
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: offer.tags
                                        .map((t) => _SkillTag(t))
                                        .toList()),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF3F4F6)),

                              // Description
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    offer.fullDescription.isNotEmpty
                                        ? offer.fullDescription
                                        : offer.description,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: kDark,
                                        height: 1.7),
                                  ),
                                ),
                              ),

                              // Fill rate
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 6),
                                child: Row(children: [
                                  const Text('Fill rate',
                                      style: TextStyle(
                                          fontSize: 12, color: kLightGrey)),
                                  const Spacer(),
                                  Text(
                                      '0/${offer.candidates == 0 ? 1 : offer.candidates}',
                                      style: const TextStyle(
                                          fontSize: 12, color: kLightGrey)),
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: const LinearProgressIndicator(
                                    value: 0,
                                    minHeight: 6,
                                    backgroundColor: Color(0xFFE5E7EB),
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(kPrimary),
                                  ),
                                ),
                              ),

                              // Action buttons
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xFFF3F4F6)))),
                                padding: const EdgeInsets.all(14),
                                child: Column(children: [
                                  Row(children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: _openAddCV,
                                        icon:
                                            const Icon(Icons.refresh, size: 15),
                                        label: const Text('Add CVs'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimary,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: _openApplyToOffer,
                                        icon: const Icon(
                                            Icons.business_center_outlined,
                                            size: 15),
                                        label: const Text('Apply to Offer'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4CAF50),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 10),
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: kBorder),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(children: [
                                          Icon(Icons.emoji_events_outlined,
                                              size: 16, color: kPrimary),
                                          const SizedBox(width: 6),
                                          const Text('Score: 0%',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: kDark)),
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: kBorder),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Icon(Icons.share_outlined,
                                          size: 18, color: kGrey),
                                    ),
                                  ]),
                                ]),
                              ),
                            ]),
                      ),
                      const SizedBox(height: 24),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── DETAIL HELPERS ──────────────────────────────────────────────────────────
class _MiniStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final int count;
  final String label;
  const _MiniStatCard(
      {required this.icon,
      required this.iconColor,
      required this.count,
      required this.label});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF3F4F6))),
        child: Row(children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$count',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: kDark)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: kLightGrey)),
          ]),
        ]),
      );
}

class _MiniStatCardScore extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String score;
  final String label;
  const _MiniStatCardScore(
      {required this.icon,
      required this.iconColor,
      required this.score,
      required this.label});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF3F4F6))),
        child: Row(children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(score,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: kDark)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: kLightGrey)),
          ]),
        ]),
      );
}

class _DetailBadge extends StatelessWidget {
  final String label;
  final Color bg, fg;
  final IconData? icon;
  const _DetailBadge(this.label,
      {required this.bg, required this.fg, this.icon});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4)
          ],
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
        ]),
      );
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _MetaItem(
      {required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 14, color: kPrimary),
        const SizedBox(width: 6),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  color: kLightGrey,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: kDark)),
        ])),
      ]);
}

class _SkillTag extends StatelessWidget {
  final String label;
  const _SkillTag(this.label);
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFED7AA)),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEA580C))),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// COOPT BOTTOM SHEET
// ═══════════════════════════════════════════════════════════════════════════════
class _CooptBottomSheet extends StatefulWidget {
  final Offer offer;
  const _CooptBottomSheet({required this.offer});
  @override
  State<_CooptBottomSheet> createState() => _CooptBottomSheetState();
}

class _CooptBottomSheetState extends State<_CooptBottomSheet> {
  int _stars = 0;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          color: kBorder,
                          borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Row(children: [
                const Icon(Icons.business_center_outlined,
                    color: kDark, size: 20),
                const SizedBox(width: 8),
                const Text('Coopt a candidate',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kDark)),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: kLightGrey)),
              ]),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    color: kPrimary, borderRadius: BorderRadius.circular(8)),
                child: const Text(
                    'Please choose your trust rate\non candidate!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 14),
              Row(children: [
                ...List.generate(
                    5,
                    (i) => GestureDetector(
                          onTap: () => setState(() => _stars = i + 1),
                          child: Icon(
                              i < _stars ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 32),
                        )),
                const SizedBox(width: 14),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.upload_outlined,
                      color: kPrimary, size: 16),
                  label: const Text('Upload',
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
              const SizedBox(height: 14),
              Row(children: [
                const Icon(Icons.refresh, color: kPrimary, size: 16),
                const SizedBox(width: 6),
                const Text('Upload CV',
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 10),
              _DropZone(),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 15),
                  label: const Text('Add CVs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.business_center_outlined, size: 15),
                  label: const Text('Apply to Offer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                )),
              ]),
            ]),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// APPLY BOTTOM SHEET
// ═══════════════════════════════════════════════════════════════════════════════
class _ApplyBottomSheet extends StatefulWidget {
  final Offer offer;
  final ScrollController scrollController;
  const _ApplyBottomSheet(
      {required this.offer, required this.scrollController});
  @override
  State<_ApplyBottomSheet> createState() => _ApplyBottomSheetState();
}

class _ApplyBottomSheetState extends State<_ApplyBottomSheet> {
  final Map<String, int> _ratings = {};
  @override
  Widget build(BuildContext context) {
    final skills = widget.offer.tags;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
        child: Row(children: [
          Center(
              child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: kBorder, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(width: 16),
          const Icon(Icons.business_center_outlined, color: kDark, size: 20),
          const SizedBox(width: 8),
          const Text('Apply to offer',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: kDark)),
          const Spacer(),
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: kLightGrey)),
        ]),
      ),
      const Divider(height: 1, color: Color(0xFFF3F4F6)),
      Expanded(
        child: ListView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              Row(children: [
                const Icon(Icons.refresh, color: kPrimary, size: 16),
                const SizedBox(width: 6),
                const Text('Upload CV',
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(width: 6),
                const Text('(optional)',
                    style: TextStyle(color: kLightGrey, fontSize: 13)),
              ]),
              const SizedBox(height: 10),
              _DropZone(),
              const SizedBox(height: 20),
              Row(children: [
                const Icon(Icons.star_border, color: kPrimary, size: 16),
                const SizedBox(width: 6),
                const Text('Self-assessment',
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kBorder),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    children: skills.asMap().entries.map((e) {
                  final skill = e.value;
                  final isLast = e.key == skills.length - 1;
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(children: [
                        Expanded(
                            child: Text(skill,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: kDark,
                                    fontWeight: FontWeight.w500))),
                        Row(
                            children: List.generate(
                                5,
                                (si) => GestureDetector(
                                      onTap: () => setState(
                                          () => _ratings[skill] = si + 1),
                                      child: Icon(
                                          si < (_ratings[skill] ?? 0)
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: const Color(0xFFD1D5DB),
                                          size: 22),
                                    ))),
                      ]),
                    ),
                    if (!isLast)
                      const Divider(
                          height: 1,
                          color: Color(0xFFF3F4F6),
                          indent: 14,
                          endIndent: 14),
                  ]);
                }).toList()),
              ),
            ]),
      ),
      const Divider(height: 1, color: Color(0xFFF3F4F6)),
      Padding(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kBorder),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            child: const Text('Cancel',
                style: TextStyle(color: kDark, fontSize: 13)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            child: const Text('Apply'),
          ),
        ]),
      ),
    ]);
  }
}

// ─── DROP ZONE ───────────────────────────────────────────────────────────────
class _DropZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.cloud_download_outlined,
                size: 32, color: kLightGrey),
            const SizedBox(height: 8),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: 'Drop file here or ',
                  style: TextStyle(fontSize: 12, color: kLightGrey)),
              TextSpan(
                  text: 'browse',
                  style: TextStyle(
                      fontSize: 12,
                      color: kPrimary,
                      fontWeight: FontWeight.w600)),
            ])),
            const SizedBox(height: 4),
            const Text('PDF, DOCX — 15 Mo max',
                style: TextStyle(fontSize: 11, color: kLightGrey)),
          ]),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADD OFFER BOTTOM SHEET
// ═══════════════════════════════════════════════════════════════════════════════
class _AddOfferSheet extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(Offer) onSubmit;
  const _AddOfferSheet(
      {required this.scrollController, required this.onSubmit});
  @override
  State<_AddOfferSheet> createState() => _AddOfferSheetState();
}

class _AddOfferSheetState extends State<_AddOfferSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _startDateCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();
  String? _type, _category, _contract;
  bool _exclusive = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _expCtrl.dispose();
    _addressCtrl.dispose();
    _startDateCtrl.dispose();
    _durationCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleCtrl.text.trim().isEmpty) return;
    widget.onSubmit(Offer(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleCtrl.text.trim(),
      company: '',
      location: _addressCtrl.text.trim(),
      price: '',
      description: _descCtrl.text.trim(),
      tags: _category != null ? [_category!] : [],
      extraTags: 0,
      type: _contract ?? 'FREELANCE',
      mode: _type ?? 'HYBRIDE',
      expired: false,
      duration: _durationCtrl.text.trim().isNotEmpty
          ? _durationCtrl.text.trim()
          : '0j',
      candidates: 0,
      postedOn: DateTime.now().toString(),
      startDate: _startDateCtrl.text.trim(),
      experience: _expCtrl.text.trim(),
      fullDescription: _descCtrl.text.trim(),
    ));
    Navigator.of(context).pop();
  }

  Widget _field(TextEditingController ctrl, String hint, {int maxLines = 1}) =>
      TextField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: kLightGrey, fontSize: 13),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kBorder)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kBorder)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimary)),
        ),
        style: const TextStyle(fontSize: 13),
      );

  Widget _labeled(String label, Widget child) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151))),
        const SizedBox(height: 4),
        child,
      ]);

  Widget _dropdown(String lbl, List<String> opts, String? val,
          void Function(String?) cb) =>
      _labeled(
          lbl,
          DropdownButtonFormField<String>(
            value: val,
            hint: const Text('Select...',
                style: TextStyle(fontSize: 13, color: kLightGrey)),
            items: opts
                .map((o) => DropdownMenuItem(
                    value: o,
                    child: Text(o, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: cb,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kBorder)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kBorder)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimary)),
            ),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down, color: kLightGrey),
          ));

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
          child: Row(children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: kBorder,
                        borderRadius: BorderRadius.circular(2)))),
            const SizedBox(width: 16),
            const Icon(Icons.work_outline, color: kDark, size: 20),
            const SizedBox(width: 8),
            const Text('Add Offer',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: kDark)),
            const Spacer(),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: kLightGrey)),
          ]),
        ),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        Expanded(
          child: ListView(
              controller: widget.scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                const Text('Offer Description',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kPrimary)),
                const SizedBox(height: 8),
                _field(_descCtrl, 'Detailed description...', maxLines: 5),
                const SizedBox(height: 20),
                const Text('Identification',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kPrimary)),
                const SizedBox(height: 12),
                _labeled('Title *', _field(_titleCtrl, 'Job title')),
                const SizedBox(height: 12),
                _labeled('Years of experience *', _field(_expCtrl, 'ex: 3')),
                const SizedBox(height: 12),
                _dropdown('Type *', kTypeOptions, _type,
                    (v) => setState(() => _type = v)),
                const SizedBox(height: 12),
                _dropdown('Category *', kCategoryOptions, _category,
                    (v) => setState(() => _category = v)),
                const SizedBox(height: 12),
                _dropdown('Contract *', kContractOptions, _contract,
                    (v) => setState(() => _contract = v)),
                const SizedBox(height: 20),
                const Text('Logistics',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kPrimary)),
                const SizedBox(height: 12),
                _labeled('Address *', _field(_addressCtrl, 'City or address')),
                const SizedBox(height: 12),
                _labeled('Start Date *', _field(_startDateCtrl, 'YYYY-MM-DD')),
                const SizedBox(height: 12),
                _labeled('Duration *', _field(_durationCtrl, 'ex: 6 mois')),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => setState(() => _exclusive = !_exclusive),
                  child: Row(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 42,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _exclusive ? kPrimary : const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: _exclusive
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('Exclusive offer (Challenge)',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  ]),
                ),
                const SizedBox(height: 20),
              ]),
        ),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        Padding(
          padding: EdgeInsets.fromLTRB(
              20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kBorder),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              ),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF374151), fontSize: 13)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              child: const Text('Submit'),
            ),
          ]),
        ),
      ]);
}
