import 'package:flutter/material.dart';
import 'package:task1/models/task.dart'; // Import Task model

class AddEditTaskDialog extends StatefulWidget {
  final Function(Task) onSaveTask;
  final Task? taskToEdit; // Optional, for editing existing tasks

  const AddEditTaskDialog({super.key, required this.onSaveTask, this.taskToEdit});

  @override
  State<AddEditTaskDialog> createState() => _AddEditTaskDialogState();
}

class _AddEditTaskDialogState extends State<AddEditTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedTime = DateTime.now().add(const Duration(hours: 1));
  Color _selectedColor = const Color(0xFF6C63FF);
  String _selectedCategory = 'Work';

  final List<Color> _colors = [
    const Color(0xFF6C63FF),
    const Color(0xFFFF6B6B),
    const Color(0xFF4ECDC4),
    const Color(0xFFFFE66D),
    const Color(0xFFFF6B9D),
  ];

  final List<String> _categories = ['Work', 'Personal', 'Design', 'Meeting', 'Study', 'Health'];

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      // Populate fields if editing an existing task
      _titleController.text = widget.taskToEdit!.title;
      _descriptionController.text = widget.taskToEdit!.description;
      _selectedTime = widget.taskToEdit!.dueTime;
      _selectedColor = widget.taskToEdit!.color;
      _selectedCategory = widget.taskToEdit!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView( // Added to prevent overflow on smaller screens
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.taskToEdit == null ? 'Add New Task' : 'Edit Task',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                minLines: 1,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Time picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Due Time: ${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _pickTime(context),
                    child: const Text('Change Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Color: '),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _colors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = color;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: _selectedColor == color
                                    ? Border.all(color: Colors.black, width: 2)
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        final task = Task(
                          id: widget.taskToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueTime: _selectedTime,
                          color: _selectedColor,
                          category: _selectedCategory,
                          isCompleted: widget.taskToEdit?.isCompleted ?? false,
                        );
                        widget.onSaveTask(task);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(widget.taskToEdit == null ? 'Add Task' : 'Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}