import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../models/workout_type.dart';
import '../widgets/empty_state.dart';
import '../widgets/workouts_view.dart';

class WorkoutsTab extends StatefulWidget {
  const WorkoutsTab({
    super.key,
    required this.workouts,
    required this.onOpen,
    required this.onToggleFavourite,
  });

  final List<Workout> workouts;
  final ValueChanged<Workout> onOpen;
  final ValueChanged<Workout> onToggleFavourite;

  @override
  State<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends State<WorkoutsTab> {
  final TextEditingController _search = TextEditingController();
  String _query = '';
  WorkoutType? _type;
  bool _showPast = true;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Workout> _visible() {
    final query = _query.trim().toLowerCase();
    final result = widget.workouts
        .where(
          (w) =>
      (_type == null || w.type == _type) &&
          (_showPast || !w.isPast) &&
          (query.isEmpty || w.title.toLowerCase().contains(query)),
    )
        .toList();
    result.sort((a, b) {
      if (a.isPast != b.isPast) {
        return a.isPast ? 1 : -1;
      }
      return a.scheduledAt.compareTo(b.scheduledAt);
    });
    return result;
  }

  void _clearSearch() {
    _search.clear();
    setState(() {
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            controller: _search,
            textInputAction: TextInputAction.search,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search workouts',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                onPressed: _clearSearch,
                icon: const Icon(Icons.clear),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: _type == null,
                onSelected: (_) {
                  setState(() {
                    _type = null;
                  });
                },
              ),
              for (final type in WorkoutType.values) ...[
                const SizedBox(width: 8),
                ChoiceChip(
                  avatar: Icon(type.icon),
                  label: Text(type.label),
                  selected: _type == type,
                  onSelected: (_) {
                    setState(() {
                      _type = type;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FilterChip(
              label: const Text('Show past'),
              selected: _showPast,
              onSelected: (value) {
                setState(() {
                  _showPast = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: visible.isEmpty
              ? EmptyState(
            icon: Icons.search_off,
            message: 'No workouts match your search',
            actionLabel: 'Clear search',
            onAction: _clearSearch,
          )
              : WorkoutsView(
            workouts: visible,
            onOpen: widget.onOpen,
            onToggleFavourite: widget.onToggleFavourite,
          ),
        ),
      ],
    );
  }
}