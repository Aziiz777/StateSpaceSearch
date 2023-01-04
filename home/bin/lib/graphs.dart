import 'cost.dart';
import 'routes.dart';

class Graph {
  List<String> station = [
    "Hamak",
    "Menna",
    "Abbaseen",
    "Karajat",
    "jsr el raees",
    "sharee el thawra",
    "Hamish",
    "Home"
  ];

  List<routes> edges = [
    routes(dist: 4, from: "Hamak", to: "Menna", vehicle: "Walk"),
    routes(dist: 6, from: "Hamak", to: "Abbaseen", vehicle: "Walk"),
    routes(dist: 8, from: "Hamak", to: "Karajat", vehicle: "Walk"),
    routes(dist: 10, from: "Hamak", to: "jsr el raees", vehicle: "Walk"),
    routes(dist: 11, from: "Hamak", to: "sharee el thawra", vehicle: "Walk"),
    routes(dist: 12, from: "Hamak", to: "Hamish", vehicle: "Walk"),
    routes(dist: 14, from: "Hamak", to: "Home", vehicle: "Walk"),
    routes(dist: 4, from: "Menna", to: "Abbaseen", vehicle: "Walk"),
    routes(dist: 6, from: "Menna", to: "Karajat", vehicle: "Walk"),
    routes(dist: 8, from: "Menna", to: "Hamish", vehicle: "Walk"),
    routes(dist: 9, from: "Menna", to: "Home", vehicle: "Walk"),
    routes(dist: 2, from: "Abbaseen", to: "Karajat", vehicle: "Walk"),
    routes(dist: 6, from: "Abbaseen", to: "jsr el raees", vehicle: "Walk"),
    routes(dist: 7, from: "Abbaseen", to: "sharee el thawra", vehicle: "Walk"),
    routes(dist: 2, from: "Karajat", to: "Hamish", vehicle: "Walk"),
    routes(dist: 13, from: "jsr el raees", to: "Karajat", vehicle: "Walk"),
    routes(
        dist: 1, from: "jsr el raees", to: "sharee el thawra", vehicle: "Walk"),
    routes(dist: 10, from: "jsr el raees", to: "Hamish", vehicle: "Walk"),
    routes(dist: 11, from: "jsr el raees", to: "Home", vehicle: "Walk"),
    routes(dist: 12, from: "sharee el thawra", to: "Karajat", vehicle: "Walk"),
    routes(dist: 6, from: "sharee el thawra", to: "Hamish", vehicle: "Walk"),
    routes(dist: 7, from: "sharee el thawra", to: "Home", vehicle: "Walk"),
    routes(dist: 1, from: "Hamish", to: "Home", vehicle: "Walk"),
    routes(
        dist: 4,
        from: "Hamak",
        to: "Menna",
        vehicle: "Bus",
        waitingTime: 15,
        vehicleSpeed: 50),
    routes(
        dist: 6,
        from: "Hamak",
        to: "Abbaseen",
        vehicle: "Bus",
        waitingTime: 15,
        vehicleSpeed: 50),
    routes(
        dist: 8,
        from: "Hamak",
        to: "Karajat",
        vehicle: "Bus",
        waitingTime: 15,
        vehicleSpeed: 50),
    routes(
        dist: 10,
        from: "Hamak",
        to: "jsr el raees",
        vehicle: "Bus",
        waitingTime: 25,
        vehicleSpeed: 40),
    routes(
        dist: 2,
        from: "Menna",
        to: "Abbaseen",
        vehicle: "Bus",
        waitingTime: 10,
        vehicleSpeed: 50),
    routes(
        dist: 3,
        from: "Menna",
        to: "Karajat",
        vehicle: "Bus",
        waitingTime: 10,
        vehicleSpeed: 50),
    routes(
        dist: 2,
        from: "Abbaseen",
        to: "Karajat",
        vehicle: "Bus",
        waitingTime: 5,
        vehicleSpeed: 50),
    routes(
        dist: 5,
        from: "Karajat",
        to: "sharee el thawra",
        vehicle: "Bus",
        waitingTime: 10,
        vehicleSpeed: 60),
    routes(
        dist: 6,
        from: "Karajat",
        to: "Hamish",
        vehicle: "Bus",
        waitingTime: 5,
        vehicleSpeed: 50),
    routes(
        dist: 13,
        from: "jsr el raees",
        to: "Karajat",
        vehicle: "Bus",
        waitingTime: 5,
        vehicleSpeed: 50),
    routes(
        dist: 1,
        from: "jsr el raees",
        to: "sharee el thawra",
        vehicle: "Bus",
        waitingTime: 10,
        vehicleSpeed: 40),
    routes(
        dist: 5,
        from: "sharee el thawra",
        to: "Karajat",
        vehicle: "Bus",
        waitingTime: 10,
        vehicleSpeed: 60),
    routes(
        dist: 6,
        from: "sharee el thawra",
        to: "Hamish",
        vehicle: "Bus",
        waitingTime: 7,
        vehicleSpeed: 50),
    routes(
        dist: 4,
        from: "Hamak",
        to: "Menna",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 100),
    routes(
        dist: 6,
        from: "Hamak",
        to: "Abbaseen",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 100),
    routes(
        dist: 8,
        from: "Hamak",
        to: "Karajat",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 100),
    routes(
        dist: 8,
        from: "Hamak",
        to: "jsr el raees",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 8,
        from: "Hamak",
        to: "sharee el thawra",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 13,
        from: "Hamak",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 2,
        from: "Menna",
        to: "Abbaseen",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 100),
    routes(
        dist: 3,
        from: "Menna",
        to: "Karajat",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 100),
    routes(
        dist: 7,
        from: "Menna",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 2,
        from: "Abbaseen",
        to: "Karajat",
        vehicle: "Taxi",
        waitingTime: 12,
        vehicleSpeed: 120),
    routes(
        dist: 12,
        from: "Abbaseen",
        to: "sharee el thawra",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 6,
        from: "Abbaseen",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 6,
        from: "Karajat",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 13,
        from: "jsr el raees",
        to: "Karajat",
        vehicle: "Taxi",
        waitingTime: 5,
        vehicleSpeed: 80),
    routes(
        dist: 1,
        from: "jsr el raees",
        to: "sharee el thawra",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 70),
    routes(
        dist: 8,
        from: "jsr el raees",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 120),
    routes(
        dist: 5,
        from: "sharee el thawra",
        to: "Karajat",
        vehicle: "Taxi",
        waitingTime: 5,
        vehicleSpeed: 80),
    routes(
        dist: 6,
        from: "sharee el thawra",
        to: "Hamish",
        vehicle: "Taxi",
        waitingTime: 4,
        vehicleSpeed: 90),
  ];
  Map<String, List<routes>> createGraph() {
    Map<String, List<routes>> graph = {};
    for (var state in station) {
      for (var route in edges) {
        if (route.from == state) {
          if (graph.containsKey(state) == false) {
            graph[state] = [route];
          } else {
            graph[state]!.add(route);
          }
        }
      }
    }
    return graph;
  }
}
