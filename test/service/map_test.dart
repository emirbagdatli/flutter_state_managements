import 'package:flutter_state_managements/feature/maps/model/map_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

void main() {
  late INetworkManager networkManager;
  setUp(() {
    networkManager = NetworkManager(options: BaseOptions(baseUrl: 'https://fluttertr-ead5c.firebaseio.com/'));
  });
  test('Fetch Map Datas', () async {
    final response = await networkManager.send<MapModel, List<MapModel>>('maps.json',
        parseModel: MapModel(), method: RequestType.GET);

    expect(response.data, isNotNull);
  });
}
