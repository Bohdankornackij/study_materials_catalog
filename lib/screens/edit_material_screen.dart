import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';

class EditMaterialScreen extends StatefulWidget {
  const EditMaterialScreen({
    super.key,
    required this.course,
    required this.material,
  });
  final Course course;
  final StudyMaterial material;
  @override
  State<EditMaterialScreen> createState() => _EditMaterialScreenState();
}

class _EditMaterialScreenState extends State<EditMaterialScreen> {
  late TextEditingController title;
  late TextEditingController topic;
  late TextEditingController content;
  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.material.title);
    topic = TextEditingController(text: widget.material.topic);
    content = TextEditingController(text: widget.material.content);
  }

  @override
  void dispose() {
    title.dispose();
    topic.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Material')),
      body: PageBody(
        children: [
          AppField(label: 'Material title', controller: title),
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
          AppField(label: 'Topic', controller: topic, lines: 2),
          AppField(
            label: widget.material.kind == MaterialKind.notes
                ? 'Notes content'
                : widget.material.kind == MaterialKind.link
                ? 'Website URL'
                : 'File name / Description',
            controller: content,
            lines: widget.material.kind == MaterialKind.notes ? 5 : 2,
          ),
          AppButton(
            label: 'Save changes',
            onPressed: () {
              if (title.text.trim().isEmpty) {
                notify(context, 'Enter a material title');
                return;
              }
              Navigator.pop(
                context,
                StudyMaterial(
                  title: title.text.trim(),
                  kind: widget.material.kind,
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
