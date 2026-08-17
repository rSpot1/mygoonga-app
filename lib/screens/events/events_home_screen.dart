import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/local_event.dart';
import '../../services/event_service.dart';
import '../../services/location_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/aggregated_status_badge.dart';
import '../../widgets/common.dart';
import 'event_detail_screen.dart';
import 'report_event_screen.dart';

class EventsHomeScreen extends StatefulWidget {
  const EventsHomeScreen({super.key});

  @override
  State<EventsHomeScreen> createState() => _EventsHomeScreenState();
}

class _EventsHomeScreenState extends State<EventsHomeScreen> {
  List<EventSummary>? _events;
  String? _error;
  bool _isLoading = true;
  double? _lat;
  double? _lng;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final position = await LocationService.instance.getCurrentPosition();
      _lat = position?.latitude;
      _lng = position?.longitude;

      // Position par defaut si la geolocalisation n'est pas disponible,
      // pour que la liste reste utilisable (l'utilisateur peut filtrer
      // manuellement par ville lors du signalement).
      final events = await EventService.instance.nearby(
        lat: _lat ?? 0,
        lng: _lng ?? 0,
        radiusKm: (_lat == null) ? 20000 : null,
      );
      if (mounted) setState(() => _events = events);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.eventsHomeAppBarTitle)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: _isLoading
              ? CenteredLoader(label: l10n.eventsHomeLoading)
              : _error != null
                  ? ErrorBanner(message: _error!, onRetry: _load)
                  : (_events == null || _events!.isEmpty)
                      ? ListView(
                          children: [
                            const SizedBox(height: 80),
                            EmptyState(
                              icon: Icons.place_outlined,
                              title: l10n.eventsHomeEmptyTitle,
                              subtitle: l10n.eventsHomeEmptySubtitle,
                            ),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _events!.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) => _EventCard(event: _events![index]),
                        ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => const ReportEventScreen()),
          );
          if (created == true) _load();
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.eventsHomeReportButton),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventSummary event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: event.eventId)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AggregatedStatusBadge(status: event.aggregatedStatus, compact: true),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, height: 1.35),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.groups_outlined, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    l10n.eventsHomeWitnessCount(event.flagCount),
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
