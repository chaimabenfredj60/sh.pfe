import 'package:flutter/material.dart';
import '../providers/app_provider.dart';

class FeedbackDialog extends StatefulWidget {
  final String language;

  const FeedbackDialog({Key? key, this.language = 'en'}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _feedbackCtrl = TextEditingController();
  bool _isError = false;

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  String _translate(String key) {
    return AppLocalizations.translate(key, widget.language);
  }

  void _validateAndSend() {
    if (_feedbackCtrl.text.isEmpty) {
      setState(() => _isError = true);
    } else {
      // Send feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_translate('feedback_sent')),
          backgroundColor: const Color(0xFF00B4A6),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _translate('send_feedback'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00B4A6),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Feedback label
              Text(
                _translate('describe_feedback'),
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Feedback textarea
              TextField(
                controller: _feedbackCtrl,
                maxLines: 8,
                onChanged: (_) {
                  if (_isError && _feedbackCtrl.text.isNotEmpty) {
                    setState(() => _isError = false);
                  }
                },
                decoration: InputDecoration(
                  hintText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: _isError ? Colors.red : Colors.grey[300]!,
                      width: _isError ? 2 : 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: _isError ? Colors.red : Colors.grey[300]!,
                      width: _isError ? 2 : 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  suffixIcon: _isError
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 32),
              // Send button
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndSend,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B4A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    _translate('send'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
