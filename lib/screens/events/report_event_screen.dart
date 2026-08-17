import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/event_service.dart';
import '../../services/location_service.dart';
import '../../theme/app_colors.dart';

class ReportEventScreen extends StatefulWidget {
  const ReportEventScreen({super.key});

  @override
  State<ReportEventScreen> createState() => _ReportEventScreenState();
}

class _ReportEventScreenState extends State<ReportEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _cityController = TextEditingController();

  double? _lat;
  double? _lng;
  bool _isLocating = false;
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _descriptionController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _attachLocation() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLocating = true);
    final position = await LocationService.instance.getCurrentPosition();
    setState(() {
      _lat = position?.latitude;
      _lng = position?.longitude;
      _isLocating = false;
    });
    if (position == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reportEventLocationUnavailable)),
      );
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _error = null;
    });
    try {
      await EventService.instance.reportEvent(
        description: _descriptionController.text.trim(),
        city: _cityController.text.trim(),
        lat: _lat,
        lng: _lng,
      );
      if (mounted) Navigator.of(context).pop(true);
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
      appBar: AppBar(title: Text(l10n.reportEventAppBarTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                Text(l10n.reportEventDescriptionLabel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: l10n.reportEventDescriptionHint,
                  ),
                  validator: (v) => (v == null || v.trim().length < 10) ? l10n.reportEventDescriptionTooShort : null,
                ),
                const SizedBox(height: 18),
                Text(l10n.reportEventCityLabel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(hintText: l10n.reportEventCityHint),
                  validator: (v) => (v == null || v.trim().isEmpty) ? l10n.reportEventCityRequired : null,
                ),
                const SizedBox(height: 18),
                OutlinedButton.icon(
                  onPressed: _isLocating ? null : _attachLocation,
                  icon: Icon(_lat != null ? Icons.location_on : Icons.my_location_outlined, size: 18),
                  label: Text(
                    _isLocating
                        ? l10n.reportEventLocatingInProgress
                        : (_lat != null ? l10n.reportEventLocationAttached : l10n.reportEventAttachLocation),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : Text(l10n.reportEventSubmitButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
