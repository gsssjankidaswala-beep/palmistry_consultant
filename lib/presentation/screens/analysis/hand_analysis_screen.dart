import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class HandAnalysisScreen extends StatefulWidget {
  const HandAnalysisScreen({super.key});

  @override
  State<HandAnalysisScreen> createState() => _HandAnalysisScreenState();
}

class _HandAnalysisScreenState extends State<HandAnalysisScreen> {
  final Map<String, TextEditingController> _lineControllers = {};
  final _specialMarksController = TextEditingController();
  final _overallController = TextEditingController();
  String _selectedHand = 'active';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    for (final line in AppConstants.palmLines) {
      _lineControllers[line] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _lineControllers.values) {
      c.dispose();
    }
    _specialMarksController.dispose();
    _overallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Analysis'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveAnalysis,
            child: _isSaving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hand Image Viewer
            _buildHandImageSection(),
            const SizedBox(height: 20),

            // Hand Type Selector
            _buildHandTypeSelector(),
            const SizedBox(height: 20),

            // Palm Lines Analysis
            _buildPalmLinesSection(),
            const SizedBox(height: 20),

            // Special Marks
            _buildSpecialMarksSection(),
            const SizedBox(height: 20),

            // Overall Reading
            _buildOverallReadingSection(),
            const SizedBox(height: 20),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveAnalysis,
                icon: const Icon(Icons.save_outlined),
                label:
                    const Text('Save Analysis', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandImageSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🖐️', style: TextStyle(fontSize: 64)),
                SizedBox(height: 8),
                Text(
                  'Client Hand Scan',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
                Text(
                  'Tap to view full image',
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.successColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Quality: 8/10',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedHand = 'active'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedHand == 'active'
                    ? AppTheme.primaryColor
                    : AppTheme.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '🖐️  Active Hand',
                  style: TextStyle(
                    color: _selectedHand == 'active'
                        ? Colors.white
                        : AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedHand = 'passive'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedHand == 'passive'
                    ? AppTheme.primaryColor
                    : AppTheme.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '✋  Passive Hand',
                  style: TextStyle(
                    color: _selectedHand == 'passive'
                        ? Colors.white
                        : AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPalmLinesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Palm Line Interpretations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        const Text(
          'Provide detailed analysis for each line',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 16),
        ...AppConstants.palmLines.map((line) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        line,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lineControllers[line],
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your analysis for $line...',
                      hintStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildSpecialMarksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Marks & Signs',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        const Text(
          'Moles, stars, crosses, islands, chains, etc.',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _specialMarksController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText:
                'Describe any special marks, their location and significance...',
          ),
        ),
      ],
    );
  }

  Widget _buildOverallReadingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Reading Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        const Text(
          'This will be shown to the client as the main reading',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _overallController,
          maxLines: 6,
          decoration: const InputDecoration(
            hintText:
                'Write a comprehensive summary of the palm reading for this client...',
          ),
        ),
      ],
    );
  }

  void _saveAnalysis() {
    setState(() => _isSaving = true);
    // TODO: Save to Firebase
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Analysis saved successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.pop(context);
      }
    });
  }
}
