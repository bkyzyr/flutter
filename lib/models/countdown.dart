import 'workout.dart';

const Duration workoutLength = Duration(hours: 1);

sealed class Countdown {
  const Countdown();

  factory Countdown.of(Workout workout, DateTime now) {
    final difference = workout.scheduledAt.difference(now);
    if (!difference.isNegative) {
      return Upcoming(difference);
    }
    final elapsed = -difference;
    if (elapsed < workoutLength) {
      return Started(elapsed);
    }
    return const Ended();
  }
}

class Upcoming extends Countdown {
  const Upcoming(this.remaining);

  final Duration remaining;
}

class Started extends Countdown {
  const Started(this.elapsed);

  final Duration elapsed;
}

class Ended extends Countdown {
  const Ended();
}