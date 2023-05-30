
import 'package:equatable/equatable.dart';

import 'cost.dart';

class state extends Equatable {
  cost? lastStationCost;
  double? money;
  double? time;
  double? health;
  state? lastState;
  String? lastVehicle;
  String? station;
  double? currentDist;
  double? currentH = 0.0;
  state(
    cost? lastStationCost,
    double? health,
    double? money,
    double? time,
    state? lastState,
    String? lastVehicle,
    String? station,
    double? currentDist,
  ) {
    this.lastStationCost = lastStationCost;
    this.money = money;
    this.health = health;
    this.time = time;
    this.lastState = lastState;
    this.lastVehicle = lastVehicle;
    this.station = station;
    this.currentDist = currentDist;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        lastStationCost,
        money,
        time,
        health,
        lastState,
        lastVehicle,
        station,
        currentDist,
        currentH
      ];
}
