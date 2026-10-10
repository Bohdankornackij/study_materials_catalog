import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../core/widgets/material_card.dart';
import '../models/catalog.dart';
import 'edit_material_screen.dart';
import 'material_menu.dart';
import 'delete_material_dialog.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key, required this.catalog});
  final Catalog catalog;
  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  void showContent(StudyMaterial material) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(material.title),
        content: SingleChildScrollView(child: SelectableText(material.content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: ink)),
          ),
        ],
      ),
    );
  }

  Future<void> showMenu(Course course, StudyMaterial material) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => MaterialMenu(material: material),
    );
    if (!mounted) {
      return;
    }
    if (action == 'edit') {
      final edited = await Navigator.push<StudyMaterial>(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditMaterialScreen(course: course, material: material),
        ),
      );
      if (edited != null && mounted) {
        setState(() {
          final index = course.materials.indexOf(material);
          course.materials[index] = edited;
        });
      }
    } else if (action == 'delete') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => const DeleteMaterialDialog(),
      );
      if (confirmed == true && mounted) {
        setState(() => course.materials.remove(material));
      }
    } else if (action == 'download') {
      notify(context, 'Demo: file download is not connected yet.');
    } else if (action == 'open') {
      showContent(material);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('All Materials'),
      ),
      body: widget.catalog.materialCount == 0
          ? const Center(
              child: Text('No materials yet.', style: TextStyle(color: muted)),
            )
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                for (final course in widget.catalog.courses)
                  if (course.materials.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (final material in course.materials)
                      MaterialCard(
                        material: material,
                        onTap: () => showContent(material),
                        onMenu: () => showMenu(course, material),
                      ),
                    const SizedBox(height: 12),
                  ],
              ],
            ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFF8C7),
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index != 1) {
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
}
