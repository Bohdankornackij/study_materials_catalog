import 'package:flutter/material.dart';

import '../../models/catalog.dart';
import '../theme.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.material,
    required this.onTap,
    required this.onMenu,
  });
  final StudyMaterial material;
  final VoidCallback onTap;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFFFFF8C7);
    String label = 'Notes';
    IconData icon = Icons.edit_note;
    if (material.kind == MaterialKind.link) {
      color = const Color(0xFFEEF0FF);
      label = 'Link';
      icon = Icons.link;
    } else if (material.kind == MaterialKind.file) {
      color = const Color(0xFFFFE8EA);
      label = 'PDF File';
      icon = Icons.picture_as_pdf_outlined;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 8, 16),
          decoration: BoxDecoration(
            border: Border.all(color: lineColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 14),
                        const SizedBox(width: 4),
                        Text(label, style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Material options',
                    onPressed: onMenu,
                    icon: const Icon(Icons.more_vert, size: 20),
                  ),
                ],
              ),
              Text(
                material.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                material.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: material.kind == MaterialKind.link
                      ? const Color(0xFF6366F1)
                      : muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
