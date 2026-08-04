import 'package:flutter/material.dart';

import 'task_service.dart';

/// Form screen to create a todo via POST `/api/todos`.
class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key, required this.token});

  static const String routeName = '/create-todo';
  static const Color primary = Color(0xFF6C72C9);

  final String token;

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TaskService _taskService = TaskService();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  DateTime? _dueDate;
  bool _loading = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CreateTodoScreen.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final todo = await _taskService.createTodo(
        token: widget.token,
        title: _title.text,
        description: _description.text,
        dueDate: _dueDate,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Created "${todo.title}"'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, todo);
    } on TaskServiceException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create todo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('New Task'),
        backgroundColor: CreateTodoScreen.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 560
                ? 520.0
                : constraints.maxWidth;

            return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Create a task',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Title is required. Description and due date are optional.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _title,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Buy milk',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: CreateTodoScreen.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _description,
                          minLines: 3,
                          maxLines: 6,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Get low fat milk',
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(bottom: 48),
                              child: Icon(Icons.notes),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: CreateTodoScreen.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: _loading ? null : _pickDueDate,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.event,
                                    color: Colors.grey.shade700,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _dueDate == null
                                          ? 'Due date (optional)'
                                          : 'Due ${_formatDate(_dueDate!)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _dueDate == null
                                            ? Colors.grey.shade600
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (_dueDate != null)
                                    IconButton(
                                      tooltip: 'Clear due date',
                                      onPressed: _loading
                                          ? null
                                          : () =>
                                              setState(() => _dueDate = null),
                                      icon: const Icon(Icons.clear, size: 20),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _loading ? null : _submit,
                            style: FilledButton.styleFrom(
                              backgroundColor: CreateTodoScreen.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Create Task',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
