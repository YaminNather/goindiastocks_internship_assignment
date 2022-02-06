class OptionalParameter<T> {
  const OptionalParameter(this.value);

  static T resolve<T>(OptionalParameter<T>? optionalParameter, T previous) {
    if(optionalParameter == null)
      return previous;
    
    return optionalParameter.value;
  }


  final T value;
}