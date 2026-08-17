import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/user_profile.dart';
import '../../services/admin_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common.dart';
import '../../widgets/role_badge.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  List<UserProfile>? _users;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final users = await AdminService.instance.listUsers();
      if (mounted) setState(() => _users = users);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _changeRole(UserProfile user) async {
    final l10n = AppLocalizations.of(context)!;
    final newRole = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.adminUsersChangeRoleTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            ),
            for (final role in ['standard', 'verifier', 'moderator', 'admin'])
              ListTile(
                leading: RoleBadge(role: role),
                trailing: user.role == role ? const Icon(Icons.check, color: AppColors.brand) : null,
                onTap: () => Navigator.of(context).pop(role),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (newRole == null || newRole == user.role) return;

    try {
      await AdminService.instance.updateRole(user.userId, role: newRole);
      _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.adminUsersAppBarTitle)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: _error != null
              ? ErrorBanner(message: _error!, onRetry: _load)
              : _users == null
                  ? const CenteredLoader()
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _users!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final user = _users![index];
                        return Card(
                          child: ListTile(
                            title: Text(user.displayName ?? user.email ?? user.userId),
                            subtitle: Text(user.email ?? '', style: const TextStyle(fontSize: 12)),
                            trailing: TextButton(
                              onPressed: () => _changeRole(user),
                              child: RoleBadge(role: user.role),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
