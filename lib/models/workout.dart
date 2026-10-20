import 'workout_type.dart';

class Workout {
  const Workout({
    required this.id,
    required this.title,
    required this.type,
    required this.scheduledAt,
    required this.maxParticipants,
    required List<String> participants,
    required this.isOnline,
    required this.venue,
    this.notes,
    this.isFavourite = false,
  }) : _participants = participants;

  Workout.empty()
      : id = '',
        title = '',
        type = WorkoutType.values.first,
        scheduledAt = DateTime.now().add(const Duration(days: 1)),
        maxParticipants = 10,
        _participants = const <String>[],
        isOnline = false,
        venue = '',
        notes = null,
        isFavourite = false;

  final String id;
  final String title;
  final WorkoutType type;
  final DateTime scheduledAt;
  final int maxParticipants;
  final List<String> _participants;
  final bool isOnline;
  final String venue;
  final String? notes;
  final bool isFavourite;

  List<String> get participants => List.unmodifiable(_participants);

  int get count => _participants.length;

  int get freePlaces => maxParticipants - count;

  bool get isFull => count >= maxParticipants;

  bool get isPast => scheduledAt.isBefore(DateTime.now());

  bool contains(String name) => _participants.contains(name);

  ({int taken, int free}) get places => (taken: count, free: freePlaces);

  Workout copyWith({
    String? id,
    String? title,
    WorkoutType? type,
    DateTime? scheduledAt,
    int? maxParticipants,
    List<String>? participants,
    bool? isOnline,
    String? venue,
    String? notes,
    bool clearNotes = false,
    bool? isFavourite,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      participants: List.unmodifiable(participants ?? _participants),
      isOnline: isOnline ?? this.isOnline,
      venue: venue ?? this.venue,
      notes: clearNotes ? null : (notes ?? this.notes),
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}