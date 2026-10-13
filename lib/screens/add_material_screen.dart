import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key, required this.course});
  final Course course;
  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final title = TextEditingController();
  final topic = TextEditingController();
  final content = TextEditingController();
  MaterialKind kind = MaterialKind.notes;
  final labels = ['Notes', 'Link', 'File'];
  final icons = [Icons.edit_note, Icons.link, Icons.attach_file];
  @override
  void dispose() {
    title.dispose();
    topic.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String contentLabel = 'Note / Summary text';
    String hint = 'Enter study notes or text...';
    if (kind == MaterialKind.link) {
      contentLabel = 'Website URL';
      hint = 'https://example.com';
    }
    if (kind == MaterialKind.file) {
      contentLabel = 'File name';
      hint = 'e.g. Guidelines_Lab2.pdf';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('New material'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: PageBody(
        children: [
          const Text(
            'Content type',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (int i = 0; i < labels.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i == 2 ? 0 : 10),
                    child: InkWell(
                      onTap: () {
                        if (kind != MaterialKind.values[i]) {
                          setState(() {
                            kind = MaterialKind.values[i];
                            content.clear();
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: kind.index == i
                              ? const Color(0xFFFFF8C7)
                              : fieldColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: kind.index == i ? yellow : lineColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              icons[i],
                              color: kind.index == i
                                  ? const Color(0xFF8A6117)
                                  : muted,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              labels[i],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          AppField(
            label: 'Material title',
            controller: title,
            hint: 'For example: Lecture 2. Flutter Framework Basics',
          ),
          const Text(
            'Course',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: fieldColor,
              border: Border.all(color: lineColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(widget.course.title),
          ),
          const SizedBox(height: 18),
          AppField(label: 'Topic', controller: topic),
          AppField(
            label: contentLabel,
            controller: content,
            hint: hint,
            lines: kind == MaterialKind.notes ? 5 : 1,
          ),
          if (kind == MaterialKind.file)
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Demo: enter a file name. File upload will be connected later.',
                style: TextStyle(fontSize: 12, color: muted),
              ),
            ),
          AppButton(
            label: 'Save material',
            onPressed: () {
              if (title.text.trim().isEmpty) {
                notify(context, 'Enter a material title');
                return;
              }
              Navigator.pop(
                context,
                StudyMaterial(
                  title: title.text.trim(),
                  kind: kind,
                  content: content.text.trim(),
                  topic: topic.text.trim().isEmpty
                      ? 'General'
                      : topic.text.trim(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
