class GameWorld {

  late List<List<int>> _currentField;
  late List<List<int>> _nextField;

  GameWorld(int width, int height) {
    _currentField = _getEmptyField(width, height);
    _nextField = _getEmptyField(width, height);
  }

  void setStartCondition(List<List<int>> startField) {
    _currentField = startField;
  }

  void setAliveOne(int x, int y) {
    _currentField[x][y] = 1;
  }

  void setDeadOne(int x, int y) {
    _currentField[x][y] = 0;
  }

  void run() {
    _buildNextField();
    _currentField = _nextField;
  }

  List<List<int>> getField() {
    return _currentField;
  }

  int isAlive(int x, int y) {
    return _currentField[x][y];
  }

  void clearField() {
    _currentField = _getEmptyField(_currentField.length, _currentField[0].length);
  }

  List<List<int>> _getEmptyField(width, height) {
    return List.generate(width, (_) => List.generate(height, (_) => 0, growable: false), growable: false);
  }

  void _buildNextField() {
    _nextField = _getEmptyField(_currentField.length, _currentField[0].length);
    for(int i = 0; i < _currentField.length; i++) {
      for(int j = 0; j < _currentField[0].length; j++) {
        int lifeCount = _countLifeAround(i, j);
        _nextField[i][j] = _makeLifeOrDead(i, j, lifeCount);
      }
    }
  }

  int _countLifeAround(int x, int y) {
    int lifeCount = 0;
    for(int i = x - 1; i <= x + 1; i++) {
      for(int j = y - 1; j <= y + 1; j++) {
        if(i == x && j == y) {
          continue;
        }
        if(i < 0 || j < 0 || i >= _currentField.length || j >= _currentField[0].length) {
          continue;
        }
        if(_currentField[i][j] == 1) {
          lifeCount++;
        }
      }
    }
    return lifeCount;
  }

  int _makeLifeOrDead(int i, int j, int lifeCount) {
    if (_currentField[i][j] == 1) {
      if(lifeCount > 3 || lifeCount < 2) {
        return 0;
      }
      else {
        return 1;
      }
    } else {
      if(lifeCount == 3) {
        return 1;
      }
      else {
        return 0;
      }
    }
  }
}