class AppData {
  static final AppData _appData = new AppData._internal();

  int workTime = 30;
  int breakTime = 5;
  int totalWorkTime = 0;
  double productivity = 0;

  int workAlarm = 0;
  int breakAlarm = 1;

  int tagNumber = 5;
  List<String> tags = ['1', '2', '3', '4', '5'];
  List<int> tagTime = [0, 0, 0, 0, 0];

  int setNumber = 1;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();

/*

*/