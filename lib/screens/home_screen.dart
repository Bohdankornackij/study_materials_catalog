import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets/course_card.dart';
import '../models/catalog.dart';
import 'add_course_screen.dart';
import 'course_screen.dart';
import 'profile_screen.dart';
import 'materials_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.catalog});
  final Catalog catalog;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = '';

  Future<void> showTab(int index) async {
    // Кожна вкладка повертає номер наступної вкладки через Navigator.pop.
    while (mounted && index != 0) {
      final nextIndex = await Navigator.push<int>(
        context,
        MaterialPageRoute(
          builder: (context) => index == 1
              ? MaterialsScreen(catalog: widget.catalog)
              : ProfileScreen(catalog: widget.catalog),
        ),
      );
      index = nextIndex ?? 0;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = widget.catalog.courses.where((course) {
      final query = search.toLowerCase();
      return course.title.toLowerCase().contains(query) ||
          course.materials.any(
            (material) => material.title.toLowerCase().contains(query),
          );
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${widget.catalog.firstName}',
                          style: const TextStyle(color: muted, fontSize: 13),
                        ),
                        const Text(
                          'My Courses',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Open profile',
                    onPressed: () => showTab(2),
                    icon: CircleAvatar(
                      backgroundColor: const Color(0xFFFFF8C7),
                      child: Text(
                        widget.catalog.initials,
                        style: const TextStyle(
                          color: Color(0xFF8A6117),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => setState(() => search = value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: muted),
                  hintText: 'Search notes and courses...',
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: courses.isEmpty
                    ? const Center(
                        child: Text(
                          'No courses found',
                          style: TextStyle(color: muted),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(
                            course: courses[index],
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CourseScreen(course: courses[index]),
                                ),
                              );
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add course',
        onPressed: () async {
          final course = await Navigator.push<Course>(
            context,
            MaterialPageRoute(builder: (context) => const AddCourseScreen()),
          );
          if (course != null && mounted) {
            setState(() => widget.catalog.courses.add(course));
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFF8C7),
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) {
            showTab(1);
          } else if (index == 2) {
            showTab(2);
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
