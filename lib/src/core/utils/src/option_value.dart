class Option<T> {
  Option(this.value) : isAbsent = false;
  Option.absent() : value = null, isAbsent = true;

  final T? value;
  final bool isAbsent;
}
