import 'package:flutter/material.dart';
import 'package:task1/models/task.dart'; // Import Task model
import 'package:task1/screens/task_detail_page.dart'; // Import TaskDetailPage
import 'package:task1/widgets/task_card.dart'; // Import TaskCard widget
import 'package:task1/widgets/add_edit_task_dialog.dart'; // Import AddEditTaskDialog widget

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage>
    with TickerProviderStateMixin {
  List<Task> tasks = [];
  List<Task> filteredTasks = []; // For search functionality
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  // Image sources for avatars (placeholders)
  final String avatar1 = 'https://placehold.co/150x150/FF0000/FFFFFF?text=A';
  final String avatar2 = 'https://placehold.co/150x150/00FF00/FFFFFF?text=B';
  final String avatar3 = 'https://placehold.co/150x150/0000FF/FFFFFF?text=C';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // No default tasks initialized here. Start with an empty list.
    filteredTasks = List.from(tasks); // Initialize filteredTasks with all tasks (which is empty)

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
      _onSearchChanged(); // Re-filter tasks after adding
    });
  }

  void _updateTask(Task updatedTask) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task.id == updatedTask.id);
      if (taskIndex != -1) {
        tasks[taskIndex] = updatedTask;
        _onSearchChanged(); // Re-filter tasks after updating
      }
    });
  }

  void _toggleTask(String id) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task.id == id);
      if (taskIndex != -1) {
        tasks[taskIndex].isCompleted = !tasks[taskIndex].isCompleted;
        _onSearchChanged(); // Re-filter tasks after toggling
      }
    });
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _onSearchChanged(); // Re-filter tasks after deleting
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTasks = tasks.where((task) {
        return task.title.toLowerCase().contains(query) ||
            task.description.toLowerCase().contains(query) ||
            task.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasksCount = tasks.where((task) => !task.isCompleted).length;
    final completedTasksCount = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;
    final completionPercentage = totalTasks > 0 ? (completedTasksCount / totalTasks) * 100 : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Opens a drawer (if defined in Scaffold)
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // This button could potentially clear the search or bring focus
                _searchController.clear(); // Clear search on tap
                FocusScope.of(context).unfocus(); // Dismiss keyboard
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications button pressed!')),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Hello Mohit',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$pendingTasksCount Tasks are pending',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              // Search Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Tasks',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Filter button pressed!')),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ongoing Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '$pendingTasksCount Tasks Left', // Dynamic "Days left" for ongoing tasks
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display Ongoing Task section only if there are tasks
              if (tasks.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${completionPercentage.toStringAsFixed(0)}%', // Dynamic completion percentage
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              tasks.first.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tasks.first.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Displaying avatars for team members
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(avatar1), // Placeholder image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(avatar2),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 40,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(avatar3),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${_formatTime(tasks.first.dueTime)}', // Display actual due time
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.rocket_launch, // Keeping icon as it's simple and effective
                          color: Color(0xFF6C63FF),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'No ongoing tasks. Add a new task to get started!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('See All button pressed!')),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFFFF6B6B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display filtered tasks
              filteredTasks.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    tasks.isEmpty ? 'No tasks added yet. Tap + to add one!' : 'No tasks found for your search.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: TaskCard(
                      task: task,
                      onToggle: () => _toggleTask(task.id),
                      onDelete: () => _deleteTask(task.id),
                      onEdit: (updatedTask) => _updateTask(updatedTask),
                      onViewDetails: () => _navigateToTaskDetail(task),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog();
        },
        backgroundColor: const Color(0xFFFF6B6B),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEditTaskDialog(
        onSaveTask: _addTask,
      ),
    );
  }

  void _navigateToTaskDetail(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(task: task),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}