import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/app_localizations.dart';
import '../../services/media_service.dart';
import '../../theme/app_colors.dart';
import 'media_result_screen.dart';

class MediaAnalyzeScreen extends StatefulWidget {
  final String? prefilledFilePath;

  const MediaAnalyzeScreen({super.key, this.prefilledFilePath});

  @override
  State<MediaAnalyzeScreen> createState() => _MediaAnalyzeScreenState();
}

class _MediaAnalyzeScreenState extends State<MediaAnalyzeScreen> {
  final _contextController = TextEditingController();
  String? _filePath;
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _filePath = widget.prefilledFilePath;
  }

  @override
  void dispose() {
    _contextController.dispose();
    super.dispose();
  }

  Future<void> _pickFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 92);
    if (picked != null) setState(() => _filePath = picked.path);
  }

  Future<void> _pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 92);
    if (picked != null) setState(() => _filePath = picked.path);
  }

  Future<void> _pickAnyFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.media);
    if (result != null && result.files.single.path != null) {
      setState(() => _filePath = result.files.single.path);
    }
  }

  Future<void> _submit() async {
    if (_filePath == null) return;
    setState(() {
      _isSubmitting = true;
      _error = null;
    });
    try {
      final analysisId = await MediaService.instance.submitMedia(
        filePath: _filePath!,
        context: _contextController.text.trim(),
        fileName: _filePath!.split(Platform.pathSeparator).last,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MediaResultScreen(analysisId: analysisId)),
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mediaAnalyzeAppBarTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.doubtfulBg, borderRadius: BorderRadius.circular(10)),
                  child: Text(_error!, style: const TextStyle(color: AppColors.doubtful, fontSize: 13)),
                ),
                const SizedBox(height: 16),
              ],
              _FilePreview(filePath: _filePath),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickFromCamera,
                      icon: const Icon(Icons.photo_camera_outlined, size: 18),
                      label: Text(l10n.mediaAnalyzeCameraButton),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickFromGallery,
                      icon: const Icon(Icons.photo_library_outlined, size: 18),
                      label: Text(l10n.mediaAnalyzeGalleryButton),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _pickAnyFile,
                icon: const Icon(Icons.folder_open_outlined, size: 18),
                label: Text(l10n.mediaAnalyzeOtherFileButton),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.mediaAnalyzeContextLabel,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _contextController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.mediaAnalyzeContextHint,
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: (_filePath == null || _isSubmitting) ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                      )
                    : Text(l10n.mediaAnalyzeSubmitButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilePreview extends StatelessWidget {
  final String? filePath;

  const _FilePreview({required this.filePath});

  bool get _isImage {
    if (filePath == null) return false;
    final lower = filePath!.toLowerCase();
    return lower.endsWith('.jpg') || lower.endsWith('.jpeg') || lower.endsWith('.png') || lower.endsWith('.webp');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: filePath == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_photo_alternate_outlined, size: 36, color: AppColors.textMuted),
                  const SizedBox(height: 8),
                  Text(l10n.mediaAnalyzeNoFileSelected, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                ],
              ),
            )
          : _isImage
              ? Image.file(File(filePath!), fit: BoxFit.cover)
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.videocam_outlined, size: 36, color: AppColors.brand),
                      const SizedBox(height: 8),
                      Text(
                        filePath!.split(Platform.pathSeparator).last,
                        style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
    );
  }
}
