import 'package:flutter/material.dart';

enum WorkoutType {
  strength('Strength', Icons.fitness_center),
  cardio('Cardio', Icons.directions_run),
  yoga('Yoga', Icons.self_improvement),
  stretching('Stretching', Icons.accessibility_new),
  hiit('HIIT', Icons.bolt);

  const WorkoutType(this.label, this.icon);

  final String label;
  final IconData icon;

  Color colorOf(ColorScheme scheme) => switch (this) {
    WorkoutType.strength => scheme.primary,
    WorkoutType.cardio => scheme.secondary,
    WorkoutType.yoga => scheme.tertiary,
    WorkoutType.stretching => scheme.error,
    WorkoutType.hiit => scheme.outline,
  };
}