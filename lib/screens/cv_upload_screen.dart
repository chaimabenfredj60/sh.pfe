import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class CvUploadScreen extends StatefulWidget {
  final String userId;

  const CvUploadScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<CvUploadScreen> createState() => _CvUploadScreenState();
}

class _CvUploadScreenState extends State<CvUploadScreen> {
  final TextEditingController _cvNameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  String? _selectedFilePath;
  String? _selectedFileName;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _cvNameController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        onFileLoading: (FilePickerStatus status) {
          print(status);
        },
      );

      if (result != null) {
        setState(() {
          _selectedFilePath = result.files.single.path;
          _selectedFileName = result.files.single.name;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la sélection du fichier: $e';
      });
    }
  }

  Future<void> _uploadCv() async {
    if (_selectedFilePath == null) {
      setState(() {
        _errorMessage = 'Veuillez sélectionner un fichier';
      });
      return;
    }

    if (_cvNameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer un nom pour le CV';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final apiService = ApiService();

      final additionalData = {
        'cvname': _cvNameController.text,
        'type':
            _typeController.text.isEmpty ? 'standard' : _typeController.text,
        'status': 'active',
      };

      final response = await apiService.uploadCvFile(
        widget.userId,
        _selectedFilePath!,
        additionalData: additionalData,
      );

      setState(() {
        _isLoading = false;
        _successMessage = 'CV uploadé avec succès!';
        _selectedFilePath = null;
        _selectedFileName = null;
        _cvNameController.clear();
        _typeController.clear();
      });

      // Afficher le message de succès pendant 3 secondes
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pop(context, true);
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors de l\'upload: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploader un CV'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Message de succès
              if (_successMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _successMessage!,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),

              // Message d'erreur
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Section sélection de fichier
              Card(
                elevation: 2,
                child: InkWell(
                  onTap: _isLoading ? null : _pickFile,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedFileName ?? 'Sélectionner un fichier CV',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'PDF, DOC ou DOCX (Max 15 MB)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Champ nom du CV
              TextField(
                controller: _cvNameController,
                decoration: InputDecoration(
                  labelText: 'Nom du CV',
                  hintText: 'Ex: CV Senior Developer',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.text_fields),
                  enabled: !_isLoading,
                ),
              ),

              const SizedBox(height: 16),

              // Champ type de CV
              TextField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Type de CV (optionnel)',
                  hintText: 'Ex: Expérience',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.category),
                  enabled: !_isLoading,
                ),
              ),

              const SizedBox(height: 32),

              // Bouton d'upload
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _uploadCv,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.upload_file),
                label: Text(
                  _isLoading ? 'Upload en cours...' : 'Uploader le CV',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Bouton annuler
              OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Annuler'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
