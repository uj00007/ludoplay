import 'dart:math';

Random random = new Random();

randomDiceValueGenerator() {
  var value = random.nextInt(7) + 1;
  if (value >= 6) {
    value = 6;
  }
  return value;
}
