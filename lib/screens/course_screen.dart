import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../core/widgets/material_card.dart';
import '../models/catalog.dart';
import 'add_material_screen.dart';
import 'edit_material_screen.dart';
import 'material_menu.dart';
import 'delete_material_dialog.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.course});
  final Course course;
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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

  Future<void> showMenu(StudyMaterial material) async {
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
              EditMaterialScreen(course: widget.course, material: material),
        ),
      );
      if (edited != null && mounted) {
        setState(() {
          final index = widget.course.materials.indexOf(material);
          widget.course.materials[index] = edited;
        });
      }
    } else if (action == 'delete') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => const DeleteMaterialDialog(),
      );
      if (confirmed == true && mounted) {
        setState(() => widget.course.materials.remove(material));
      }
    } else if (action == 'download') {
      notify(context, 'Demo: file download is not connected yet.');
    } else if (action == 'open') {
      showContent(material);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topics = widget.course.materials
        .map((material) => material.topic)
        .toSet()
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const Text(
              'Topics and learning materials',
              style: TextStyle(fontSize: 12, color: muted),
            ),
          ],
        ),
      ),
      body: widget.course.materials.isEmpty
          ? const Center(
              child: Text(
                'No materials yet. Add your first note.',
                style: TextStyle(color: muted),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              children: [
                for (final topic in topics) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      topic.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  for (final material in widget.course.materials.where(
                    (material) => material.topic == topic,
                  ))
                    MaterialCard(
                      material: material,
                      onTap: () => showContent(material),
                      onMenu: () => showMenu(material),
                    ),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add material',
        onPressed: () async {
          final material = await Navigator.push<StudyMaterial>(
            context,
            MaterialPageRoute(
              builder: (context) => AddMaterialScreen(course: widget.course),
            ),
          );
          if (material != null && mounted) {
            setState(() => widget.course.materials.add(material));
          }
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
