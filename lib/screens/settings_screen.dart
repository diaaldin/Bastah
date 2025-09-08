import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/providers/app_provider.dart';
import 'package:bastah/screens/admin_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(appLocalizations.languageLabel),
            trailing: DropdownButton<String>(
              value: Provider.of<AppProvider>(context).locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                DropdownMenuItem(value: 'he', child: Text('Hebrew')),
              ],
              onChanged: (value) {
                if (value != null) {
                  Provider.of<AppProvider>(context, listen: false)
                      .setLocale(Locale(value));
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(appLocalizations.adminLoginTitle),
            leading: const Icon(Icons.admin_panel_settings),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdminLoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
