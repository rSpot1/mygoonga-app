import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../services/share_intent_service.dart';
import '../events/events_home_screen.dart';
import '../media/media_home_screen.dart';
import '../media/media_analyze_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _shareService = ShareIntentService.instance;

  @override
  void initState() {
    super.initState();
    _handleInitialShare();
    _shareService.listen(_handleSharedFiles);
  }

  Future<void> _handleInitialShare() async {
    final files = await _shareService.getInitialSharedFiles();
    if (files.isNotEmpty) _openAnalyzeScreenWithFile(files.first.path);
  }

  void _handleSharedFiles(files) {
    if (files.isNotEmpty) _openAnalyzeScreenWithFile(files.first.path);
  }

  void _openAnalyzeScreenWithFile(String path) {
    _shareService.resetIntent();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MediaAnalyzeScreen(prefilledFilePath: path)),
      );
    });
  }

  @override
  void dispose() {
    _shareService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isModerator = auth.profile?.isModerator ?? false;
    final l10n = AppLocalizations.of(context)!;

    final tabs = <Widget>[
      const MediaHomeScreen(),
      const EventsHomeScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.image_search_outlined),
            activeIcon: const Icon(Icons.image_search),
            label: l10n.navAnalyze,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.place_outlined),
            activeIcon: const Icon(Icons.place),
            label: l10n.navEvents,
          ),
          BottomNavigationBarItem(
            icon: Icon(isModerator ? Icons.shield_outlined : Icons.person_outline),
            activeIcon: Icon(isModerator ? Icons.shield : Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
