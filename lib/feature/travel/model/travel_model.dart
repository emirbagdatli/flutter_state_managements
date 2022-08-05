class TravelModel {
  final String title;
  final String subTitle;
  final String imageName;

  TravelModel({required this.title, required this.subTitle, required this.imageName});

  String get imagePath => 'asset/images/feed/$imageName.png';

  static final List<TravelModel> mockItems = [
    TravelModel(title: 'sapporo', subTitle: 'sapporo Tower', imageName: 'discover'),
    TravelModel(title: 'osaka', subTitle: 'Japan', imageName: 'dest'),
    TravelModel(title: 'fiji mountain', subTitle: 'fiji mountain', imageName: 'fiji'),
  ];
}
