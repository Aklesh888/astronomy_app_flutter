class PlanetsModel {
  String name;
  String description;
  String distanceFromSun;
  String diameter;
  String mass;
  String gravity;
  String orbitalPeriod;
  String dayLength;
  int moons;

  PlanetsModel({
    required this.name,
    required this.description,
    required this.distanceFromSun,
    required this.diameter,
    required this.mass,
    required this.gravity,
    required this.orbitalPeriod,
    required this.dayLength,
    required this.moons,
  });
}
