class CityName {
  final List<Result> results;
  CityName({
    this.results,
  });

  factory CityName.fromMap(Map<String, dynamic> json) {
    var newResultList = List<Result>();
    json['results'].forEach((value) {
      newResultList.add(value);
    });

    return CityName(results: newResultList);
  }
}

class Result {
  String cityName;
  Result({
    this.cityName,
  });

  Result.fromMap(Map<String, dynamic> json) {
    cityName = json['name'];
  }
}
