import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'dashboard_model.dart';

/// Household member avatar shown in the profile switcher row.
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.member,
    required this.selected,
    required this.onTap,
  });

  final HouseholdMember member;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: member.color.withOpacity(0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? member.color : Colors.transparent,
                width: 2,
              ),
            ),
            child: Text(member.emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 4),
          Text(
            member.name,
            style: theme.bodySmall.copyWith(
              color: selected ? theme.primaryText : theme.secondaryText,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// A small stat card used in the dashboard's summary row.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(value, style: theme.headlineSmall),
            Text(label, style: theme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// A shopping list summary card shown in the horizontal shopping rail.
class ShoppingListCard extends StatelessWidget {
  const ShoppingListCard({super.key, required this.list, required this.onTap});

  final ShoppingList list;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: list.color.withOpacity(0.16),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(list.icon, color: list.color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(list.name, style: theme.titleMedium),
            const SizedBox(height: 2),
            Text('${list.checkedCount}/${list.itemCount} items',
                style: theme.bodySmall),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: list.progress,
                minHeight: 6,
                backgroundColor: theme.alternate,
                valueColor: AlwaysStoppedAnimation<Color>(list.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single chore row with an assignee avatar and a done checkbox.
class ChoreTile extends StatelessWidget {
  const ChoreTile({
    super.key,
    required this.chore,
    required this.onToggle,
  });

  final ChoreItem chore;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: chore.done ? theme.success : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: chore.done ? theme.success : theme.secondaryText,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: chore.done
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Icon(chore.icon, color: theme.secondaryText, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chore.title,
                  style: theme.bodyLarge.copyWith(
                    decoration:
                        chore.done ? TextDecoration.lineThrough : null,
                    color: chore.done
                        ? theme.secondaryText
                        : theme.primaryText,
                  ),
                ),
                Text(chore.dueLabel, style: theme.bodySmall),
              ],
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: chore.assignee.color.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(chore.assignee.emoji, style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}

/// A single to-do task row with a priority indicator and a done checkbox.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
  });

  final TaskItem task;
  final VoidCallback onToggle;

  Color _priorityColor(FlutterFlowTheme theme) {
    switch (task.priority) {
      case TaskPriority.high:
        return theme.error;
      case TaskPriority.medium:
        return theme.warning;
      case TaskPriority.low:
        return theme.accent1;
    }
  }

  String _priorityLabel() {
    switch (task.priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final color = _priorityColor(theme);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: task.done ? theme.success : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.done ? theme.success : theme.secondaryText,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: task.done
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.bodyLarge.copyWith(
                    decoration:
                        task.done ? TextDecoration.lineThrough : null,
                    color:
                        task.done ? theme.secondaryText : theme.primaryText,
                  ),
                ),
                Text(task.dueLabel, style: theme.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _priorityLabel(),
              style: theme.labelSmall.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom navigation bar for the main planner sections.
class DashboardBottomNavBar extends StatelessWidget {
  const DashboardBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.secondaryBackground,
      selectedItemColor: theme.primary,
      unselectedItemColor: theme.secondaryText,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_rounded),
          label: 'Shopping',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cleaning_services_rounded),
          label: 'Chores',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_rounded),
          label: 'Tasks',
        ),
      ],
    );
  }
}
