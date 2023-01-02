import 'dart:math';

import 'bin/lib/cost.dart';
import 'bin/lib/graphs.dart';
import 'bin/lib/routes.dart';
import 'bin/lib/state.dart';

void main(List<String> arg) {
  Graph graph = Graph();
  //init graph with the static data

  Map<String, List<routes>> map = graph.createGraph();
  //determine the final destination
  var final_destination = "Home";

//calculate the cost of the route
  cost calculateCost(routes edge) {
    if (edge.vehicle == "Walk") {
      var time = (edge.dist! / 5.5) * 60;
      var health = (-10.0 * edge.dist!);
      return cost(0, time, health);
    } else if (edge.vehicle == "Bus") {
      var money = 400.0;
      // *60 for convert hours to minutes
      var time = (edge.waitingTime! + (edge.dist! / edge.vehicleSpeed!) * 60);
      var health = (-5.0 * edge.dist!);
      return cost(money, time, health);
    } else {
      var money = 1000 * edge.dist!;
      var time = (edge.waitingTime! + (edge.dist! / edge.vehicleSpeed!) * 60);
      var health = (5.0 * edge.dist!);
      return cost(money, time, health);
    }
  }

  // to print the graph
  // map.keys.forEach((element) {
  //   print(element + ":");
  //   for (routes r in map[element]!) {
  //     print("From:${r.from}   " + "To:${r.to}   " + "Vehicle:${r.vehicle}");
  //     // print("the cost:");
  //     // var cost = calculateCost(r);
  //     // print("money:  ${cost.money}  " +
  //     //     "time:  ${cost.time}  " +
  //     //     "health:  ${cost.health}  ");
  //   }
  // });
  List<state>? queue = [];
  List<state>? visited = [];
  List<state>? solution = [];

  List<routes>? getPossibleStation(state currentState) {
    var currentStation = currentState.station;
    var possibleNextStation = map[currentStation];
    return possibleNextStation;
  }

  state goNextState(state currentState, routes destinationRoute) {
    cost c = calculateCost(destinationRoute);
    var lastState = currentState;
    var lastVehicle = destinationRoute.vehicle;
    var nextStation = destinationRoute.to;
    // print("costHealth" + "${c.health}");
    state newState = state(
        cost(
          lastState.lastStationCost!.money! + c.money!,
          lastState.lastStationCost!.time! + c.time!,
          lastState.lastStationCost!.health! + c.health!,
        ),
        lastState.health! + c.health!,
        lastState.money! - c.money!,
        lastState.time! + c.time!,
        lastState,
        lastVehicle,
        nextStation,
        lastState.currentDist! + destinationRoute.dist!);
    // heuristic(newState);
    return newState;
  }

  double? heuristic(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) => a.dist!.compareTo(b.dist!)));
      // print("******************************7");
      // print(possible[0].dist);
      // print(possible[1].dist);
      // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&7");

      var a = possible[0].vehicle;
      if (a == "Bus") {
        heuris = heuris! + possible[0].dist!;
        currentState = goNextState(currentState, possible[0]);
      } else if (a == "Taxi") {
        heuris = heuris! + possible[0].dist!;
        currentState = goNextState(currentState, possible[0]);
      } else {
        heuris = heuris! + possible[0].dist!;
        currentState = goNextState(currentState, possible[0]);
      }
    }
    return heuris;
  }

  double? heuristicTime(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) => (a.waitingTime! + (a.dist! / a.vehicleSpeed!))
          .compareTo(b.waitingTime! + (b.dist! / b.vehicleSpeed!))));
      var a = possible[0].vehicle;

      if (a == "Bus") {
        heuris = heuris! +
            possible[0].waitingTime! +
            (possible[0].dist! / possible[0].vehicleSpeed!);
        currentState = goNextState(currentState, possible[0]);
      } else if (a == "Taxi") {
        heuris = heuris! +
            possible[0].waitingTime! +
            (possible[0].dist! / possible[0].vehicleSpeed!);

        currentState = goNextState(currentState, possible[0]);
      } else {
        heuris = heuris! +
            possible[0].waitingTime! +
            (possible[0].dist! / possible[0].vehicleSpeed!);

        currentState = goNextState(currentState, possible[0]);
      }
    }
    return heuris;
  }

  double? heuristicMoney(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) =>
          a.calculateCost(a).money!.compareTo(b.calculateCost(b).money!)));
      var a = possible[0].vehicle;
      if (a == "Bus") {
        heuris = heuris! + calculateCost(possible[0]).money!;
        currentState = goNextState(currentState, possible[0]);
      } else if (a == "Taxi") {
        heuris = heuris! + calculateCost(possible[0]).money!;
        currentState = goNextState(currentState, possible[0]);
      } else {
        // heuris = heuris;
        currentState = goNextState(currentState, possible[0]);
      }
    }
    return heuris;
  }

  double? heuristicHealth(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) =>
          a.calculateCost(a).health!.compareTo(b.calculateCost(b).health!)));
      var a = possible.last.vehicle;
      if (a == "Bus") {
        heuris = heuris! + calculateCost(possible.last).health!;
        currentState = goNextState(currentState, possible.last);
      } else if (a == "Taxi") {
        heuris = heuris! + calculateCost(possible.last).health!;
        currentState = goNextState(currentState, possible.last);
      } else {
        heuris = heuris! + calculateCost(possible.last).health!;
        currentState = goNextState(currentState, possible.last);
      }
    }
    return heuris;
  }

  double? heuristicAll(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) => (a.waitingTime! + (a.dist! / a.vehicleSpeed!))
          .compareTo(b.waitingTime! + (b.dist! / b.vehicleSpeed!))));
      possible.sort(((a, b) =>
          a.calculateCost(a).money!.compareTo(b.calculateCost(b).money!)));
      possible.sort(((a, b) =>
          a.calculateCost(a).health!.compareTo(b.calculateCost(b).health!)));
      // print("******************************7");
      // print(possible[0].dist);
      // print(possible[1].dist);
      // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&7");

      var a = possible[0].vehicle;

      var heurisTime = possible[0].waitingTime! +
          (possible[0].dist! / possible[0].vehicleSpeed!);
      var heurisMoney = calculateCost(possible[0]).money!;
      var heurisHealth = calculateCost(possible[0]).health!;
      if (a == "Bus") {
        heuris = heuris! + (heurisHealth + heurisMoney + heurisTime);
        currentState = goNextState(currentState, possible[0]);
      } else if (a == "Taxi") {
        heuris = heuris! + (heurisHealth + heurisMoney + heurisTime);
        currentState = goNextState(currentState, possible[0]);
      } else {
        heuris = heuris! + (heurisHealth + heurisMoney + heurisTime);
        currentState = goNextState(currentState, possible[0]);
      }
    }
    return heuris;
  }

  aStar() {
    queue.add(state(cost(0, 0, 0), 100, 2000, 0.0, null, null, "Hamak", 0.0));
    print("d");
    while (queue.isNotEmpty) {
      //All
      // queue.sort((a, b) => a.currentH!.compareTo(b.currentH!));
      // queue.sort((a, b) => ((a.time! + a.money! + a.health!) + a.currentH!)
      //     .compareTo((b.time! + b.money! + b.health!) + b.currentH!));
      //Health
      // queue.sort((a, b) => a.currentH!.compareTo(b.currentH!));
      // queue.sort((a, b) => (100 - a.health! + a.currentH!)
      //     .compareTo(100 - b.health! + b.currentH!));
      //money
      // queue.sort((a, b) => (2000 - a.money! + a.currentH!)
      //     .compareTo(2000 - b.money! + b.currentH!));
      // queue.sort((a, b) => a.currentH!.compareTo(b.currentH!));
      //Time
      // queue.sort((a, b) => a.currentH!.compareTo(b.currentH!));
      // queue.sort(
      //     (a, b) => (a.time! + a.currentH!).compareTo(b.time! + b.currentH!));
      //dist
      queue.sort((a, b) => a.currentH!.compareTo(b.currentH!));
      queue.sort((a, b) => (a.currentDist! + a.currentH!)
          .compareTo(b.currentDist! + b.currentH!));
      state currentState = queue.removeAt(0);
      for (state v in visited) {
        if (v == currentState) {
          print("q");
          continue;
        }
      }
      visited.add(currentState);

      //check win
      if (final_destination == currentState.station) {
        print("solved" + "${currentState.lastStationCost}");
        for (state step = currentState;
            step.lastState != null;
            step = step.lastState!) {
          solution.add(step);
        }
        //for print solution path
        print(solution.length);
        print("visited" + "${visited.length}");
        for (var a in solution) {
          print(a.lastVehicle.toString() + a.station!);
          print("Current Health${a.health}");
          print("Current Money${a.money}");
          print("Current Time${a.time}");
          print("Current Dist${a.currentDist}");
        }
        return solution;
      }
      var possible = getPossibleStation(currentState);
      if (possible != null) {
        for (routes edge in possible) {
          cost edgeCost = calculateCost(edge);
          // current health != 0 and current money != 0
          if (0 <= currentState.health! + edgeCost.health! &&
              0 <= currentState.money! - edgeCost.money!) {
            if (edge.vehicle == "Bus") {
              var newstate = goNextState(currentState, edge);
              var h = heuristic(newstate);
              newstate.currentH = h;
              queue.add(newstate);
            } else if (edge.vehicle == "Taxi") {
              var newstate = goNextState(currentState, edge);
              var h = heuristic(newstate);
              newstate.currentH = h;
              queue.add(newstate);
            } else {
              var newstate = goNextState(currentState, edge);
              var h = heuristic(newstate);

              newstate.currentH = h;
              queue.add(newstate);
            }
          } else {
            continue;
          }
        }
      } else {
        continue;
      }
    }
    print("fail");
    return null;
  }

  aStar();
}
