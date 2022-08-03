import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_state_managements/feature/maps/service/map_service.dart';
import 'package:flutter_state_managements/feature/maps/viewModel/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_managements/product/constants/product_constants.dart';
import 'package:flutter_state_managements/product/init/network/network_product.dart';
import 'package:flutter_state_managements/product/model/state/project_context.dart';
import 'package:flutter_state_managements/product/utility/extension/map_model_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSelectView extends StatefulWidget {
  const MapSelectView({Key? key}) : super(key: key);

  @override
  State<MapSelectView> createState() => _MapSelectViewState();
}

class _MapSelectViewState extends State<MapSelectView> {
  late final MapViewModel _mapViewModel;
  GoogleMapController? _controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapViewModel = MapViewModel(MapService(NetworkProduct.instace.networkManager));
    _mapViewModel.fetchAllMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _googleMaps(),
        Positioned(
            height: MediaQuery.of(context).size.height * 0.2,
            right: 0,
            left: 0,
            bottom: kToolbarHeight,
            child: _pageViewAnimals())
      ],
    ));
  }

  Widget _pageViewAnimals() {
    return Observer(builder: (_) {
      return PageView.builder(
          onPageChanged: (value) {
            _mapViewModel.changeIndex(value);
            _controller?.animateCamera(CameraUpdate.newLatLng(_mapViewModel.mapModelItems[value].latlong));
          },
          itemCount: _mapViewModel.mapModelItems.length,
          controller: PageController(viewportFraction: 0.8),
          itemBuilder: ((context, index) {
            return Card(
                child: Image.network(
              _mapViewModel.mapModelItems[index].detail?.photoUrl ?? '',
              fit: BoxFit.cover,
            ));
          }));
    });
  }

  Observer _googleMaps() {
    return Observer(builder: (_) {
      return _mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              markers: _mapViewModel.mapModelItems.toMarkers(_mapViewModel.selectedIndex),
              initialCameraPosition: CameraPosition(target: _mapViewModel.mapModelItems.first.latlong, zoom: 12));
    });
  }
}
