import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/success_alert_dialog.dart';
import 'cv_upload_screen.dart';

class CvListScreen extends StatefulWidget {
  final String userId;

  const CvListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<CvListScreen> createState() => _CvListScreenState();
}

class _CvListScreenState extends State<CvListScreen> {
  late Future<dynamic> _cvsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCvs();
  }

  void _loadCvs() {
    setState(() {
      _cvsFuture = _apiService.get('/api/MyCvtech/${widget.userId}');
    });
  }

  Future<void> _deleteCv(String cvId) async {
    try {
      await _apiService.delete('/api/MyCvtech/${widget.userId}/$cvId');
      _loadCvs();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CV supprimé avec succès')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  Future<void> _downloadCv(String filename) async {
    try {
      await _apiService.downloadCvFile(filename);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Téléchargement en cours...')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de téléchargement: $e')),
        );
      }
    }
  }

  Future<void> _submitCv(String cvName, String cvId) async {
    try {
      print('DEBUG: Soumission CV - cvName: $cvName, cvId: $cvId');

      // Appel API pour enregistrer la candidature
      await _apiService.post(
        '/api/application',
        data: {
          'user': widget.userId,
          'cv': cvId,
          'offer': null,
          'status': 'submitted',
          'type': 'application',
        },
      );

      print('DEBUG: Réponse API successful');

      // Affichage du dialog sans condition mounted (context reste valide)
      if (!mounted) {
        print('DEBUG: Widget not mounted, aborting dialog');
        return;
      }

      print('DEBUG: Affichage du dialog de succès');
      SuccessAlertDialog.show(
        context: context,
        title: 'Candidature reçue',
        message:
            'Votre CV "$cvName" a été envoyé avec succès!\n\nVotre candidature a été transmise au Super Admin pour examen.',
        buttonText: 'Continuer',
      );
    } catch (e) {
      print('DEBUG: Erreur lors de la soumission: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la soumission: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes CVs'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: FutureBuilder<dynamic>(
        future: _cvsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erreur: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadCvs,
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          final cvData = snapshot.data;
          final cvList = cvData?['MyCV'] as List? ?? [];

          if (cvList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text('Aucun CV uploadé'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CvUploadScreen(userId: widget.userId),
                        ),
                      );
                      if (result == true) {
                        _loadCvs();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Uploader un CV'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cvList.length,
            itemBuilder: (context, index) {
              final cv = cvList[index];
              final cvName = cv['cvname'] ?? 'CV sans nom';
              final fileUrl = cv['fileUrl'] ?? '';
              final originalFileName = cv['originalFileName'] ?? 'Fichier';
              final uploadedAt = cv['uploadedAt'] != null
                  ? DateTime.parse(cv['uploadedAt']).toString().split('.')[0]
                  : 'Date inconnue';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.description,
                        color: Colors.blue.shade700,
                      ),
                      title: Text(
                        cvName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            originalFileName,
                            style: TextStyle(color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Uploadé: $uploadedAt',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: const Row(
                              children: [
                                Icon(Icons.download, size: 18),
                                SizedBox(width: 8),
                                Text('Télécharger'),
                              ],
                            ),
                            onTap: () => _downloadCv(fileUrl),
                          ),
                          PopupMenuItem(
                            child: const Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Supprimer',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirmer la suppression'),
                                  content: const Text(
                                    'Êtes-vous sûr de vouloir supprimer ce CV?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _deleteCv(cv['_id']);
                                      },
                                      child: const Text('Supprimer',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Boutons d'action (Postuler et Envoyer)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _submitCv(cvName, cv['_id']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              icon: const Icon(Icons.send, size: 16),
                              label: const Text('Postuler'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _submitCv(cvName, cv['_id']);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.blue.shade700),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              icon: const Icon(Icons.mail, size: 16),
                              label: const Text('Envoyer'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CvUploadScreen(userId: widget.userId),
            ),
          );
          if (result == true) {
            _loadCvs();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouveau CV'),
        backgroundColor: Colors.blue.shade700,
      ),
    );
  }
}
