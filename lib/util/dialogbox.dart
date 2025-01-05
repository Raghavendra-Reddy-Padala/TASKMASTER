import 'package:flutter/material.dart';
import 'package:todolistapp/util/button.dart';

class Dialogbox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onsave;
  final VoidCallback oncancel;
  final bool isEditing;

  const Dialogbox({
    super.key,
    required this.controller,
    required this.onsave,
    required this.oncancel,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        isEditing ? 'Edit Task' : 'Add New Task',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 180),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter task description',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Buttons(
                  text: 'Cancel',
                  onPressed: oncancel,
                  isPrimary: false,
                ),
                const SizedBox(width: 12),
                Buttons(
                  text: isEditing ? 'Update' : 'Save',
                  onPressed: onsave,
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
