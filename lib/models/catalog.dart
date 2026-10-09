import 'package:flutter/material.dart';

enum MaterialKind { notes, link, file }

class StudyMaterial {
  StudyMaterial({
    required this.title,
    required this.kind,
    required this.content,
    this.topic = 'Topic 2. Requirements Specification and Graphic Design',
  });
  final String title;
  final MaterialKind kind;
  final String content;
  final String topic;
}

class Course {
  Course({
    required this.title,
    required this.description,
    required this.color,
    this.topics = 1,
    List<StudyMaterial>? materials,
  }) : materials = materials ?? [];
  final String title;
  final String description;
  final Color color;
  final int topics;
  final List<StudyMaterial> materials;
}

// Демонстраційні дані зберігаються тільки під час роботи застосунку.
class Catalog {
  String firstName = 'Bohdan';
  String lastName = 'Kornatskyi';
  String email = 'student@lpnu.ua';
  String get initials {
    String result = '';
    if (firstName.isNotEmpty) {
      result += firstName[0];
    }
    if (lastName.isNotEmpty) {
      result += lastName[0];
    }
    return result.isEmpty ? 'U' : result.toUpperCase();
  }

  final courses = <Course>[
    Course(
      title: 'Cross-platform Programming',
      description: 'Flutter, Dart, mobile app development',
      color: const Color(0xFFFACC15),
      topics: 6,
      materials: [
        StudyMaterial(
          title: 'Dart Programming Language Basics',
          kind: MaterialKind.notes,
          content: 'Introduction to the basic structure',
        ),
        StudyMaterial(
          title: 'Guidelines_Lab2.pdf',
          kind: MaterialKind.file,
          content: '2.1 MB · Software Engineering Department',
        ),
        StudyMaterial(
          title: 'Material Design 3 Components',
          kind: MaterialKind.link,
          content: 'https://m3.material.io',
        ),
      ],
    ),
    Course(
      title: 'Databases',
      description: 'SQL, relationship modeling, and queries',
      color: const Color(0xFF38BDF8),
      topics: 4,
      materials: [
        StudyMaterial(
          title: 'Relational database basics',
          kind: MaterialKind.notes,
          content: 'Tables, keys, relationships and SQL queries.',
        ),
      ],
    ),
    Course(
      title: 'Software Construction',
      description: 'Design patterns, SOLID, clean architecture',
      color: const Color(0xFF4ADE80),
      topics: 5,
      materials: [
        StudyMaterial(
          title: 'SOLID principles',
          kind: MaterialKind.notes,
          content: 'Five principles of object-oriented design.',
        ),
      ],
    ),
  ];
  int get materialCount =>
      courses.fold(0, (sum, course) => sum + course.materials.length);
}
