class CanLogStreakEntryUseCase {
  bool execute({required DateTime? lastCheckIn, DateTime? now}){
    if (lastCheckIn == null){
      return true;
    }
    final currentDate = now ?? DateTime.now();
    final diff = currentDate.difference(lastCheckIn);
    return (diff > Duration(hours: 24));
  }
}