import 'dart:developer';

import 'package:flutter_state_managements/feature/maps/service/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../model/map_model.dart';
part 'map_view_model.g.dart';

class MapViewModel = _MapViewModelBase with _$MapViewModel;

abstract class _MapViewModelBase with Store {
  final IMapService mapService;

  @observable
  bool isLoading = false;
  @observable
  List<MapModel> mapModelItems = [];
  @observable
  int selectedIndex = 0;
  _MapViewModelBase(this.mapService);

  @action
  Future<void> fetchAllMaps() async {
    _changeLoading();
    final response = await mapService.fetchMapItems();
    _changeLoading();

    mapModelItems = response ?? [];
  }

  @action
  void _changeLoading() {
    isLoading = !isLoading;
  }

  @action
  void changeIndex(int index) {
    selectedIndex = index;
  }
}
