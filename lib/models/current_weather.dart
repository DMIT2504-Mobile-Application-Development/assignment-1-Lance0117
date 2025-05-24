class CurrentWeather {
 //region private members
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;

  CurrentWeather(String city, String description, double currentTemp, DateTime currentTime, DateTime sunrise, DateTime sunset) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunrise = sunrise;
    this.sunset = sunset;
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

  set currentTemp(double value){
    if(value > 100 || value < -100){
      throw Exception('Temperature must be between -100 and 100');
    }

    _currentTemp = value;
  }


  DateTime get currentTime => _currentTime;

  set currentTime(DateTime value){
    if (value.isAfter(DateTime.now())){
      throw Exception('Current time cannot be in the future');
    }

    _currentTime = value;
  }


  DateTime get sunrise => _sunrise;

  set sunrise(DateTime value){
    if (!(value.year == currentTime.year &&
        value.month == currentTime.month &&
        value.day == currentTime.day)){
      throw Exception('Sunrise must be on the same day as current time');
    } else if (value.isAfter(sunset)){
      throw Exception('Sunrise cannot be after sunset');
    }

    _sunrise = value;
  }


  DateTime get sunset => _sunset;

  set sunset(DateTime value){
    if (!(value.year == currentTime.year &&
        value.month == currentTime.month &&
        value.day == currentTime.day)){
      throw Exception('Sunset must be on the same day as current time');
    } else if (value.isBefore(sunrise)){
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
    final currentTime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
    final sunrise = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000);
    final sunset = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000);

    return CurrentWeather(city, description, currentTemp, currentTime, sunrise, sunset);
  }












  //endregion









}