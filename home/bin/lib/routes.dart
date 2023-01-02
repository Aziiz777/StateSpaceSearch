import 'cost.dart';

class routes {
  double? dist;
  String? from;
  String? to;
  String? vehicle;
  double? waitingTime = 0.0;
  double? vehicleSpeed;

  routes(
      {required double? dist,
      required String? from,
      required String? to,
      required String? vehicle,
      double? waitingTime,
      double? vehicleSpeed}) {
    this.dist = dist;
    this.from = from;
    this.to = to;
    this.vehicle = vehicle;
    this.waitingTime = waitingTime;
    this.vehicleSpeed = vehicleSpeed;
    if (vehicle == "Walk") {
      this.vehicleSpeed = 5.5;
    }
    if (waitingTime == null) {
      this.waitingTime = 0.0;
    }
  }

  cost calculateCost(routes edge) {
    if (edge.vehicle == "Walk") {
      var time = (edge.dist! / 5.5) * 60;
      var health = (-10.0 * edge.dist!);
      // print("Healthhhh" + "$health");
      return cost(0, time, health);
    } else if (edge.vehicle == "Bus") {
      var money = 400.0;
      var time = (edge.waitingTime! + (edge.dist! / edge.vehicleSpeed!) * 60);
      var health = (-5.0 * edge.dist!);
      // print("Healthhhh" + "$health");
      return cost(money, time, health);
    } else {
      var money = 1000 * edge.dist!;
      var time = (edge.waitingTime! + (edge.dist! / edge.vehicleSpeed!) * 60);
      var health = (5.0 * edge.dist!);
      return cost(money, time, health);
    }
  }
}
