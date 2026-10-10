import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../models/catalog.dart';

// Екран 10 у Figma реалізовано як нижнє меню, а не окрему сторінку.
class MaterialMenu extends StatelessWidget {
  const MaterialMenu({super.key, required this.material});
  final StudyMaterial material;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              material.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const Text('Choose an action', style: TextStyle(color: muted)),
            const SizedBox(height: 16),
            ListTile(
              tileColor: fieldColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit material'),
              onTap: () => Navigator.pop(context, 'edit'),
            ),
            const SizedBox(height: 8),
            ListTile(
              tileColor: fieldColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(
                material.kind == MaterialKind.file
                    ? Icons.download_outlined
                    : Icons.open_in_new,
              ),
              title: Text(
                material.kind == MaterialKind.file
                    ? 'Download file'
                    : 'Open material',
              ),
              onTap: () => Navigator.pop(
                context,
                material.kind == MaterialKind.file ? 'download' : 'open',
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              tileColor: const Color(0xFFFFF0F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'Delete material',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => Navigator.pop(context, 'delete'),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: ink)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
