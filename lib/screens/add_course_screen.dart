import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});
  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  final colors = [
    yellow,
    const Color(0xFF38BDF8),
    const Color(0xFF4ADE80),
    const Color(0xFFA855F7),
    const Color(0xFFFB7185),
  ];
  int selectedColor = 0;
  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Course'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: PageBody(
        children: [
          const Text(
            'Select Color Marker',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: [
              for (int i = 0; i < colors.length; i++)
                InkWell(
                  onTap: () => setState(() => selectedColor = i),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors[i],
                      shape: BoxShape.circle,
                    ),
                    child: selectedColor == i
                        ? const Icon(Icons.check, size: 22)
                        : null,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          AppField(
            label: 'Course Title',
            controller: title,
            hint: 'e.g. Cross-platform Programming',
          ),
          AppField(
            label: 'Course Description',
            controller: description,
            hint: 'Brief description of the course, goals and topics...',
            lines: 5,
          ),
          AppButton(
            label: 'Create Course',
            color: const Color(0xFFF59E0B),
            onPressed: () {
              if (title.text.trim().isEmpty) {
                notify(context, 'Enter a course title');
                return;
              }
              Navigator.pop(
                context,
                Course(
                  title: title.text.trim(),
                  description: description.text.trim(),
                  color: colors[selectedColor],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
