class Comment{
  String? _comment;
  String? _time;

  Comment(this._comment, this._time);

  String? get time => _time;

  set time(String? value) {
    _time = value;
  }

  String? get comment => _comment;

  set comment(String? value) {
    _comment = value;
  }
}