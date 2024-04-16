class ParameterSingleton {
  static final ParameterSingleton _instance = ParameterSingleton._();
  late String _parameterValue;

  factory ParameterSingleton() {
    return _instance;
  }

  ParameterSingleton._();

  void setParameterValue(String value) {
    _parameterValue = value;
  }

  String getParameterValue() {
    return _parameterValue;
  }
}
