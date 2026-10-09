import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.catalog});
  final Catalog catalog;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Profile'),
      ),
      body: PageBody(
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8C7),
                        shape: BoxShape.circle,
                        border: Border.all(color: yellow, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          widget.catalog.initials,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8A6117),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton.filled(
                        tooltip: 'Change photo',
                        style: IconButton.styleFrom(
                          backgroundColor: ink,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => notify(
                          context,
                          'Demo: profile photo upload will be connected later.',
                        ),
                        icon: const Icon(Icons.camera_alt_outlined, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.catalog.firstName} ${widget.catalog.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                Text(
                  widget.catalog.email,
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _stat('${widget.catalog.courses.length}', 'Courses'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _stat('${widget.catalog.materialCount}', 'Materials'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: fieldColor,
              border: Border.all(color: lineColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _detail('FIRST NAME', widget.catalog.firstName),
                const Divider(height: 1, color: lineColor),
                _detail('LAST NAME', widget.catalog.lastName),
                const Divider(height: 1, color: lineColor),
                _detail('EMAIL ADDRESS', widget.catalog.email),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditProfileScreen(catalog: widget.catalog),
                ),
              );
              if (mounted) {
                setState(() {});
              }
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cloud_sync_outlined),
            title: const Text('Cloud synchronization'),
            trailing: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF22C55E),
            ),
            onTap: () => notify(
              context,
              'Demo: cloud synchronization is not connected yet.',
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              foregroundColor: Colors.red,
              side: const BorderSide(color: Color(0xFFF3CDD1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFF8C7),
        selectedIndex: 2,
        onDestinationSelected: (index) {
          if (index != 2) {
            Navigator.pop(context, index);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            label: 'Materials',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: fieldColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: lineColor),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8A6117),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: muted)),
      ],
    ),
  );
  Widget _detail(String label, String value) => Padding(
    padding: const EdgeInsets.all(14),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              color: muted,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}
