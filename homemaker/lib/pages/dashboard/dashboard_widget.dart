import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'dashboard_components.dart';
import 'dashboard_model.dart';

/// The Homemaker home dashboard.
///
/// Gives a household an at-a-glance view of what needs doing: a member
/// switcher, quick stats (shopping items left, chores and tasks due today),
/// browsable shopping lists, today's chores, and upcoming tasks — all on
/// top of a bottom tab bar for the planner's main sections.
class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  static const String routeName = 'Dashboard';
  static const String routePath = '/dashboard';

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  String _activeMemberId = HomemakerMockData.members.first.id;
  int _selectedNavIndex = 0;

  final List<ShoppingList> _shoppingLists = HomemakerMockData.shoppingLists;
  final List<ChoreItem> _chores = HomemakerMockData.buildChores();
  final List<TaskItem> _tasks = HomemakerMockData.buildTasks();

  int get _pendingShoppingItems => _shoppingLists.fold(
      0, (sum, list) => sum + (list.itemCount - list.checkedCount));

  int get _choresToday =>
      _chores.where((c) => c.dueLabel == 'Today' && !c.done).length;

  int get _tasksDueSoon => _tasks.where((t) => !t.done).length;

  void _toggleChore(ChoreItem chore) {
    setState(() => chore.done = !chore.done);
  }

  void _toggleTask(TaskItem task) {
    setState(() => task.done = !task.done);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final activeMember = HomemakerMockData.members
        .firstWhere((m) => m.id == _activeMemberId);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildHeader(theme, activeMember),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildMemberSwitcher(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildStatsRow(theme),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildSectionHeader(theme, 'Shopping Lists'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: _shoppingLists.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) => ShoppingListCard(
                    list: _shoppingLists[index],
                    onTap: () {},
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildSectionHeader(theme, "Today's Chores"),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Column(
                  children: _chores
                      .map((chore) => ChoreTile(
                            chore: chore,
                            onToggle: () => _toggleChore(chore),
                          ))
                      .toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: _buildSectionHeader(theme, 'Tasks'),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Column(
                  children: _tasks
                      .map((task) => TaskTile(
                            task: task,
                            onToggle: () => _toggleTask(task),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: DashboardBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }

  Widget _buildHeader(FlutterFlowTheme theme, HouseholdMember activeMember) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning,', style: theme.bodyMedium),
              Text('${activeMember.name}! 🏡', style: theme.displaySmall),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.primary.withOpacity(0.14),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.notifications_none_rounded, color: theme.primary),
        ),
      ],
    );
  }

  Widget _buildMemberSwitcher(FlutterFlowTheme theme) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: HomemakerMockData.members.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final member = HomemakerMockData.members[index];
          return MemberAvatar(
            member: member,
            selected: member.id == _activeMemberId,
            onTap: () => setState(() => _activeMemberId = member.id),
          );
        },
      ),
    );
  }

  Widget _buildStatsRow(FlutterFlowTheme theme) {
    return Row(
      children: [
        StatTile(
          icon: Icons.shopping_cart_rounded,
          value: '$_pendingShoppingItems',
          label: 'Items to buy',
          color: theme.primary,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.cleaning_services_rounded,
          value: '$_choresToday',
          label: 'Chores today',
          color: theme.secondary,
        ),
        const SizedBox(width: 12),
        StatTile(
          icon: Icons.checklist_rounded,
          value: '$_tasksDueSoon',
          label: 'Tasks open',
          color: theme.tertiary,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(FlutterFlowTheme theme, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.headlineSmall),
        GestureDetector(
          onTap: () {},
          child: Text(
            'See all',
            style: theme.bodyMedium.copyWith(color: theme.primary),
          ),
        ),
      ],
    );
  }
}
