import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../utils/format.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
    required this.onToggleFavourite,
  });

  final Workout workout;
  final VoidCallback onTap;
  final VoidCallback onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final (:taken, :free) = workout.places;
    final String? badge =
    workout.isFull ? 'FULL' : (free <= 5 ? '$free left' : null);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: workout.type.colorOf(scheme),
                    child: Icon(workout.type.icon, color: scheme.surface),
                  ),
                  if (badge != null)
                    Positioned(
                      bottom: -6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: workout.isFull
                                ? scheme.error
                                : scheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: workout.isFull
                                  ? scheme.onError
                                  : scheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      workout.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      formatDate(workout.scheduledAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      workout.isOnline ? 'Online' : workout.venue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      '$taken / ${workout.maxParticipants} joined',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavourite,
                icon: Icon(
                  workout.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: workout.isFavourite ? scheme.error : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}