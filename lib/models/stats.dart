mixin Stats {
  int _points = 10;
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _skill = 10;

  int get points => _points;

  Map<String, int> get statAsMap => {
        "health": _health,
        "attack": _attack,
        "defense": _defense,
        "skill": _skill
      };

  List<Map<String, String>> get statsAsFormattedList => [
        {"title": "helath", "value": _health.toString()},
        {"title": "attack", "value": _attack.toString()},
        {"title": "defense", "value": _defense.toString()},
        {"title": "skill", "value": _skill.toString()},
      ];

  void increaseStats(String str) {
    if (_points > 0) {
      if (Stats == _health) {
        _health++;
      }
      if (Stats == _attack) {
        _attack++;
      }
      if (Stats == _defense) {
        _defense++;
      }
      if (Stats == _skill) {
        _skill++;
      }
      _points--;
    }
  }

  void decreaseStats(String str) {
    if (Stats == _health && _health > 5) {
      _health--;
      _points++;
    }
    if (Stats == _attack && _attack > 5) {
      _attack--;
      _points++;
    }
    if (Stats == _defense && _defense > 5) {
      _defense--;
      _points++;
    }
    if (Stats == _skill && _skill > 5) {
      _skill--;
      _points++;
    }
  }

  void setStats({required int points, required Map<String, dynamic> stats}) {
    _points = points;
    _attack = stats['attack'];
    _defense = stats['defense'];
    _health = stats['health'];
    _skill = stats['skill'];
  }
}
