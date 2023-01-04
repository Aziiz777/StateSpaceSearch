import 'dart:math';

import 'bin/lib/cost.dart';
import 'bin/lib/graphs.dart';
import 'bin/lib/routes.dart';
import 'bin/lib/state.dart';

void main(List<String> arg) {
  Graph map = Graph();
  //init graph with the static data
  Map<String, List<routes>> graph = map.createGraph();
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
  graph.keys.forEach((element) {
    print(element + ":");
    for (routes r in graph[element]!) {
      print("To:${r.to}   " + "Vehicle:${r.vehicle}");
      // print("the cost:");
      var cost = calculateCost(r);
      print("money:  ${cost.money}  " +
          "time:  ${cost.time}  " +
          "health:  ${cost.health}  ");
    }
  });
  List<state>? queue = [];
  List<state>? visited = [];
  List<state>? solution = [];
  List<state>? closed = [];

  List<routes>? getPossibleStation(state currentState) {
    var currentStation = currentState.station;
    var possibleNextStation = graph[currentStation];
    return possibleNextStation;
  }

  state goNextState(state currentState, routes destinationRoute) {
    cost edgeCost = calculateCost(destinationRoute);
    // if (0 <= currentState.health! + edgeCost.health! &&
    //     0 <= currentState.money! - edgeCost.money!) {
    var lastState = currentState;
    var lastVehicle = destinationRoute.vehicle;
    var nextStation = destinationRoute.to;
    double newhealth;
    if ((lastState.health! + edgeCost.health!) >= 100.0) {
      newhealth = 100.0;
    } else {
      newhealth = lastState.health! + edgeCost.health!;
    }
    state newState = state(
        cost(
          lastState.lastStationCost!.money! + edgeCost.money!,
          lastState.lastStationCost!.time! + edgeCost.time!,
          lastState.lastStationCost!.health! + edgeCost.health!,
        ),
        newhealth,
        lastState.money! - edgeCost.money!,
        lastState.time! + edgeCost.time!,
        lastState,
        lastVehicle,
        nextStation,
        lastState.currentDist! + destinationRoute.dist!);
    // heuristic(newState);
    return newState;
    // } else {
    //   return null;
    // }
  }

  double? heuristic(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) => a.dist!.compareTo(b.dist!)));
      heuris = heuris! + possible[0].dist!;
      currentState = goNextState(currentState, possible[0]);
    }
    return heuris;
  }

  double? heuristicTime(state currentState) {
    double? heuris = 0.0;
    while (getPossibleStation(currentState) != null) {
      List<routes>? possible = getPossibleStation(currentState);
      possible!.sort(((a, b) =>
          (a.waitingTime! + (a.dist! / a.vehicleSpeed!) * 60)
              .compareTo(b.waitingTime! + (b.dist! / b.vehicleSpeed!) * 60)));
      heuris = heuris! +
          possible[0].waitingTime! +
          (possible[0].dist! / possible[0].vehicleSpeed!) * 60;
      currentState = goNextState(currentState, possible[0]);
    }
    return heuris;
  }

  double? heuristicMoney(state currentState) {
    double? heuris = 0.0;
    while (!closed.contains(currentState)) {
      List<routes>? possible = getPossibleStation(currentState);
      if (possible != null) {
        possible.sort(((a, b) =>
            a.calculateCost(a).money!.compareTo(b.calculateCost(b).money!)));
        var cost = calculateCost(possible[0]);
        heuris = heuris! + cost.money!;
        if (0 <= currentState.health! + cost.health!) {
          currentState = goNextState(currentState, possible[0]);
        } else {
          heuris = 0.0;
          break;
        }
      }
    }
    return heuris;
  }

  double? heuristicHealth(state currentState) {
    double? heuris = 0.0;
    while (closed.contains(currentState)) {
      List<routes>? possible = getPossibleStation(currentState);

      if (possible != null) {
        possible.sort(((a, b) =>
            a.calculateCost(a).health!.compareTo(b.calculateCost(b).health!)));
        var cost = calculateCost(possible.last);
        heuris = heuris! + cost.health!;
        if (0 <= currentState.health! + cost.health! &&
            0 <= currentState.money! - cost.money!) {
          currentState = goNextState(currentState, possible.last);
        } else {
          closed.add(currentState);
          heuris = 0.0;
          break;
        }
      }
    }
    return heuris;
  }

  double? heuristicAll(state currentState) {
    double? heuris = 0.0;
    while (!closed.contains(currentState)) {
      List<routes>? possible = getPossibleStation(currentState);
      if (possible != null) {
        possible.sort((a, b) {
          int sort = (a.waitingTime! + (a.dist! / a.vehicleSpeed!))
              .compareTo(b.waitingTime! + (b.dist! / b.vehicleSpeed!));
          if (sort == 0) {
            int sort2 =
                a.calculateCost(a).money!.compareTo(b.calculateCost(b).money!);
            if (sort2 == 0) {
              return a
                  .calculateCost(a)
                  .health!
                  .compareTo(b.calculateCost(b).health!);
            } else {
              return sort2;
            }
          } else {
            return sort;
          }
        });
        var cost = calculateCost(possible[0]);
        heuris = heuris! + (cost.health! + cost.money! + cost.time!);
        if (0 <= currentState.health! + cost.health! &&
            0 <= currentState.money! - cost.money!) {
          currentState = goNextState(currentState, possible[0]);
        } else {
          closed.add(currentState);
          heuris = 0.0;

          break;
        }
      }
    }
    return heuris;
  }

  aStar() {
    state init =
        state(cost(0, 0, 0), 100, 10000, 0.0, null, null, "Hamak", 0.0);
    queue.add(init);
    print("d");
    print("s");
    while (queue.isNotEmpty) {
      //time
      // queue.sort((a, b) {
      //   int sort = ((a.time!) + a.currentH!).compareTo((b.time!) + b.currentH!);
      //   if (sort == 0) {
      //     return a.currentH!.compareTo(b.currentH!);
      //   }
      //   return sort;
      // });
      //money
      // queue.sort((a, b) {
      //   int sort = ((init.money! - a.money!) + a.currentH!)
      //       .compareTo((init.money! - b.money!) + b.currentH!);
      //   if (sort == 0) {
      //     return a.currentH!.compareTo(b.currentH!);
      //   }
      //   return sort;
      // });
      //health
      // queue.sort((a, b) {
      //   int sort = ((init.health! - a.health!) + a.currentH!)
      //       .compareTo((init.health! - b.health!) + b.currentH!);
      //   if (sort == 0) {
      //     return a.currentH!.compareTo(b.currentH!);
      //   }
      //   return sort;
      // });
      //all
      queue.sort((a, b) {
        int sort =
            ((a.time! + (init.health! - a.health!) + (init.money! - a.money!)) +
                    a.currentH!)
                .compareTo((b.time! +
                        (init.health! - b.health!) +
                        (init.money! - a.money!)) +
                    b.currentH!);
        if (sort == 0) {
          return a.currentH!.compareTo(b.currentH!);
        }
        return sort;
      });
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
        //to print solution path
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
            var newstate = goNextState(currentState, edge);
            var h = heuristicAll(newstate);
            newstate.currentH = h;
            queue.add(newstate);
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
