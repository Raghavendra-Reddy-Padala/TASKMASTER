import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskcomplted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletefunc;
  final VoidCallback editfunc;
  final Color cardColor;
  final Color primaryColor;

  const ToDoTile({
    super.key,
    required this.taskname,
    required this.taskcomplted,
    required this.onChanged,
    required this.deletefunc,
    required this.editfunc,
    required this.cardColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deletefunc,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => editfunc(),
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskcomplted,
                onChanged: onChanged,
                activeColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  taskname,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: taskcomplted ? TextDecoration.lineThrough : TextDecoration.none,
                    color: taskcomplted ? Colors.grey : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}