class Calculators {

  double calcBMR(double weight, double height, int age, String gender) {
    double BMR;
    if (gender == 'Male') {
      BMR =
          ((10 * weight) + (6.25 * height) - (5 * age) + 5);
    } else {
      BMR = ((10 * weight) +
          (6.25 * height) -
          (5 * age) -
          161);
    }
    return BMR;
  }

  double calcGoalRange(double BMR, String goal) {
    switch (goal.toLowerCase()) {
      case 'lose weight':
        return BMR * 0.9;
      case 'maintain weight':
        return BMR;
      case 'gain weight':
        return BMR * 1.1;
      default:
        return 0;
    }
  }

  double calcCaloriesBurned(double weight, int time, double met) {
    double calBurned =
        (((((((met) * (weight) * 3.5) / 200) * time) * 100)) / 100)
            .roundToDouble();
    return calBurned;
  }
}