import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ReportBuilderScreen extends StatefulWidget {
  const ReportBuilderScreen({super.key});

  @override
  State<ReportBuilderScreen> createState() => _ReportBuilderScreenState();
}

class _ReportBuilderScreenState extends State<ReportBuilderScreen> {
  final _titleController =
      TextEditingController(text: 'Palmistry Reading Report');
  final _contentController = TextEditingController();
  final _lifelineController = TextEditingController();
  final _headlineController = TextEditingController();
  final _heartlineController = TextEditingController();
  final _fatelineController = TextEditingController();
  final _findingsController = TextEditingController();
  final _recommendationsController = TextEditingController();
  bool _isSaving = false;
  bool _isGeneratingPdf = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _lifelineController.dispose();
    _headlineController.dispose();
    _heartlineController.dispose();
    _fatelineController.dispose();
    _findingsController.dispose();
    _recommendationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Report'),
        actions: [
          TextButton.icon(
            onPressed: _isGeneratingPdf ? null : _generatePdf,
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            label: const Text('PDF', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Report Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 20),

            // Line Interpretations
            _buildSectionHeader('Palm Line Interpretations', '🖐️'),
            const SizedBox(height: 12),
            _buildLineField('Life Line', _lifelineController,
                'Describe the life line reading...'),
            _buildLineField('Head Line', _headlineController,
                'Describe the head line reading...'),
            _buildLineField('Heart Line', _heartlineController,
                'Describe the heart line reading...'),
            _buildLineField('Fate Line', _fatelineController,
                'Describe the fate line reading...'),
            const SizedBox(height: 20),

            // Key Findings
            _buildSectionHeader('Key Findings', '🔍'),
            const SizedBox(height: 12),
            TextFormField(
              controller: _findingsController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                    'List key findings (one per line):\n• Strong career prospects\n• Good health indicators\n• ...',
              ),
            ),
            const SizedBox(height: 20),

            // Recommendations
            _buildSectionHeader('Recommendations', '💡'),
            const SizedBox(height: 12),
            TextFormField(
              controller: _recommendationsController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                    'List recommendations (one per line):\n• Wear blue sapphire\n• Meditate daily\n• ...',
              ),
            ),
            const SizedBox(height: 20),

            // Overall Content
            _buildSectionHeader('Detailed Reading', '📝'),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText:
                    'Write the complete detailed palmistry reading for the client...',
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isSaving ? null : _saveDraft,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save Draft'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isSaving ? null : _sendToClient,
                    icon: _isSaving
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.send_outlined),
                    label: const Text('Send to Client'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String emoji) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.textPrimary),
        ),
      ],
    );
  }

  Widget _buildLineField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  void _saveDraft() {
    setState(() => _isSaving = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Draft saved!'),
            backgroundColor: AppTheme.infoColor,
          ),
        );
      }
    });
  }

  void _sendToClient() {
    setState(() => _isSaving = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report sent to client successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.pop(context);
      }
    });
  }

  void _generatePdf() {
    setState(() => _isGeneratingPdf = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF generated and ready to share!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    });
  }
}
