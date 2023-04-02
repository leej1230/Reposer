// Calculates the difference in days between given date and the date when this function was called

int differenceBetweenToday(DateTime givenDate) {
  DateTime today = DateTime.now();

  DateTime todayDate = DateTime(today.year, today.month, today.day);
  DateTime compareDate =
      DateTime(givenDate.year, givenDate.month, givenDate.day);

  return todayDate.difference(compareDate).inDays;
}
