class CurrentWeather {
  //region private members
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;

  CurrentWeather(
      {required String city,
      required String description,
      required double currentTemp,
      required DateTime currentTime,
      required DateTime sunrise,
      required DateTime sunset}) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;

    if (!(sunrise.year == currentTime.year &&
        sunrise.month == currentTime.month &&
        sunrise.day == currentTime.day)) {
      throw Exception('Sunrise must be on the same day as current time');
    } else if (sunrise.isAfter(sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }

    if (!(sunset.year == currentTime.year &&
        sunset.month == currentTime.month &&
        sunset.day == currentTime.day)) {
      throw Exception('Sunset must be on the same day as current time');
    } else if (sunset.isBefore(sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }

    _sunset = sunset;
    _sunrise = sunrise;
  }

  // Define properties
  String get city => _city;

  set city(String value) {
    if (value.trim().isEmpty) {
      throw Exception('City cannot be empty');
    }

    _city = value;
  }

  String get description => _description;

  set description(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Description cannot be empty');
    }

    _description = value;
  }

  double get currentTemp => _currentTemp;

  set currentTemp(double value) {
    if (value > 100 || value < -100) {
      throw Exception('Temperature must be between -100 and 100');
    }

    _currentTemp = value;
  }

  DateTime get currentTime => _currentTime;

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }

    _currentTime = value;
  }

  DateTime get sunrise => _sunrise;

  set sunrise(DateTime value) {
    if (!(value.year == _currentTime.year &&
        value.month == _currentTime.month &&
        value.day == _currentTime.day)) {
      throw Exception('Sunrise must be on the same day as current time');
    }
    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }

    _sunrise = value;
  }

  DateTime get sunset => _sunset;

  set sunset(DateTime value) {
    if (!(value.year == _currentTime.year &&
        value.month == _currentTime.month &&
        value.day == _currentTime.day)) {
      throw Exception('Sunset must be on the same day as current time');
    }
    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }

    _sunset = value;
  }
  //endregion

  // region methods

  factory CurrentWeather.fromOpenWeatherData(dynamic data) {
    final city = data['name'];
    final description = data['weather'][0]['description'];
    final currentTemp = data['main']['temp'].toDouble();
    final currentTime =
        DateTime.fromMillisecondsSinceEpoch((data['dt'] * 1000).toInt());
    final sunrise = DateTime.fromMillisecondsSinceEpoch(
        (data['sys']['sunrise'] * 1000).toInt());
    final sunset = DateTime.fromMillisecondsSinceEpoch(
        (data['sys']['sunset'] * 1000).toInt());

    return CurrentWeather(
      city: city,
      description: description,
      currentTemp: currentTemp,
      currentTime: currentTime,
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  @override
  String toString() =>
      "City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset";

  //endregion
}
