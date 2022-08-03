import 'package:flutter_state_managements/feature/maps/model/map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension MapMarkersExtension on List<MapModel> {
  Set<Marker> toMarkers(int selectedIndex) {
    return Set.of(map((e) => Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(
            this[selectedIndex] == e ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueCyan),
        markerId: MarkerId('${e.lat}'),
        position: e.latlong)));
  }
}
