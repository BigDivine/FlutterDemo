class Bicycle {
  int size;
  int _speed = 0;
  int get speed => _speed;

  String name;
  // Bicycle(this.size, this.speed, this.name);
  Bicycle(int size, String name) {
    this.size = size;
    this.name = name;
  }
  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => "$name $size speed is $_speed mph";
}
