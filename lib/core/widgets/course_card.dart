import 'package:flutter/material.dart';

import '../../models/catalog.dart';
import '../theme.dart';

// Однакова картка використовується для всіх дисциплін у каталозі.
class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, required this.onTap});
  final Course course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: lineColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: course.color.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${course.topics} topics',
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: const TextStyle(color: muted, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${course.materials.length} materials',
                      style: TextStyle(
                        color: course.color == yellow
                            ? const Color(0xFF8A6117)
                            : course.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 4,
                child: ColoredBox(color: course.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
