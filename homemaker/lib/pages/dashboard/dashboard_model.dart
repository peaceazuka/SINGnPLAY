import 'package:flutter/material.dart';

/// A member of the household who chores and tasks can be assigned to.
class HouseholdMember {
  const HouseholdMember({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  final String id;
  final String name;
  final String emoji;
  final Color color;
}

/// A shopping list (groceries, hardware store, etc) with its progress.
class ShoppingList {
  const ShoppingList({
    required this.name,
    required this.icon,
    required this.color,
    required this.itemCount,
    required this.checkedCount,
  });

  final String name;
  final IconData icon;
  final Color color;
  final int itemCount;
  final int checkedCount;

  double get progress => itemCount == 0 ? 0 : checkedCount / itemCount;
}

/// A recurring or one-off household chore.
class ChoreItem {
  ChoreItem({
    required this.title,
    required this.assignee,
    required this.dueLabel,
    required this.icon,
    this.done = false,
  });

  final String title;
  final HouseholdMember assignee;
  final String dueLabel;
  final IconData icon;
  bool done;
}

enum TaskPriority { low, medium, high }

/// A one-off to-do item for the household (errands, admin, projects).
class TaskItem {
  TaskItem({
    required this.title,
    required this.dueLabel,
    required this.priority,
    this.done = false,
  });

  final String title;
  final String dueLabel;
  final TaskPriority priority;
  bool done;
}

/// Everything the dashboard screen needs, as sample data until this is
/// wired up to a real backend.
class HomemakerMockData {
  const HomemakerMockData._();

  static const List<HouseholdMember> members = [
    HouseholdMember(id: 'mom', name: 'Mom', emoji: '👩', color: Color(0xFF5B8266)),
    HouseholdMember(id: 'dad', name: 'Dad', emoji: '👨', color: Color(0xFFE07A5F)),
    HouseholdMember(id: 'zoe', name: 'Zoe', emoji: '👧', color: Color(0xFFE8B84B)),
    HouseholdMember(id: 'sam', name: 'Sam', emoji: '🧒', color: Color(0xFF7FA99B)),
  ];

  static final List<ShoppingList> shoppingLists = [
    ShoppingList(
      name: 'Groceries',
      icon: Icons.local_grocery_store_rounded,
      color: const Color(0xFF5B8266),
      itemCount: 14,
      checkedCount: 6,
    ),
    ShoppingList(
      name: 'Hardware Store',
      icon: Icons.hardware_rounded,
      color: const Color(0xFFE07A5F),
      itemCount: 5,
      checkedCount: 1,
    ),
    ShoppingList(
      name: 'Pharmacy',
      icon: Icons.local_pharmacy_rounded,
      color: const Color(0xFF7FA99B),
      itemCount: 3,
      checkedCount: 3,
    ),
  ];

  static List<ChoreItem> buildChores() => [
        ChoreItem(
          title: 'Take out the trash',
          assignee: members[3],
          dueLabel: 'Today',
          icon: Icons.delete_outline_rounded,
        ),
        ChoreItem(
          title: 'Vacuum living room',
          assignee: members[2],
          dueLabel: 'Today',
          icon: Icons.cleaning_services_rounded,
        ),
        ChoreItem(
          title: 'Water the plants',
          assignee: members[0],
          dueLabel: 'Today',
          icon: Icons.local_florist_rounded,
          done: true,
        ),
        ChoreItem(
          title: 'Wash the dishes',
          assignee: members[1],
          dueLabel: 'Tomorrow',
          icon: Icons.local_dining_rounded,
        ),
      ];

  static List<TaskItem> buildTasks() => [
        TaskItem(
          title: 'Pay electricity bill',
          dueLabel: 'Due today',
          priority: TaskPriority.high,
        ),
        TaskItem(
          title: 'Book dentist appointment',
          dueLabel: 'Due tomorrow',
          priority: TaskPriority.medium,
        ),
        TaskItem(
          title: 'Renew car insurance',
          dueLabel: 'Due in 3 days',
          priority: TaskPriority.medium,
        ),
        TaskItem(
          title: 'Sort donation boxes',
          dueLabel: 'This week',
          priority: TaskPriority.low,
        ),
      ];
}
