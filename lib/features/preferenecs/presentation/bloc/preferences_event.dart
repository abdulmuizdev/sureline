abstract class PreferencesEvent {
  const PreferencesEvent();
}

class GetLastSevenDaysStreakData extends PreferencesEvent {
  GetLastSevenDaysStreakData();
}

class OnShareStreakPressed extends PreferencesEvent {
  final double screenWidth;
  final double screenHeight;
  const OnShareStreakPressed({required this.screenWidth, required this.screenHeight});
}

class GetStreakStatus extends PreferencesEvent {}

class GetFavouritesCount extends PreferencesEvent {}

class GetRandomQuotes extends PreferencesEvent {
  final int option;
  const GetRandomQuotes(this.option);
}