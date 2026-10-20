import 'package:flutter/material.dart';

import '../models/workout.dart';
import 'workout_card.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({
    super.key,
    required this.workouts,
    required this.onOpen,
    required this.onToggleFavourite,
  });

  final List<Workout> workouts;
  final ValueChanged<Workout> onOpen;
  final ValueChanged<Workout> onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget card(Workout workout) {
          return WorkoutCard(
            key: ValueKey(workout.id),
            workout: workout,
            onTap: () => onOpen(workout),
            onToggleFavourite: () => onToggleFavourite(workout),
          );
        }

        if (constraints.maxWidth >= 600) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisExtent: 148,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: workouts.length,
            itemBuilder: (context, index) => card(workouts[index]),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: workouts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) => card(workouts[index]),
        );
      },
    );
  }
}