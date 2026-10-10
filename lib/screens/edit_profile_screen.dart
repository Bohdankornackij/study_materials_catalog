import 'package:flutter/material.dart';

import '../core/widgets/app_widgets.dart';
import '../models/catalog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.catalog});
  final Catalog catalog;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  @override
  void initState() {
    super.initState();
    firstName = TextEditingController(text: widget.catalog.firstName);
    lastName = TextEditingController(text: widget.catalog.lastName);
    email = TextEditingController(text: widget.catalog.email);
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit Profile')),
    body: PageBody(
      children: [
        AppField(label: 'First name', controller: firstName),
        AppField(label: 'Last name', controller: lastName),
        AppField(
          label: 'Email',
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        AppButton(
          label: 'Save changes',
          onPressed: () {
            widget.catalog.firstName = firstName.text.trim();
            widget.catalog.lastName = lastName.text.trim();
            widget.catalog.email = email.text.trim();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
