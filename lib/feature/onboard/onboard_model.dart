class OnBoardModel {
  final String title;
  final String desc;
  final String imageName;

  OnBoardModel(this.title, this.desc, this.imageName);

  String get imageWithPath => 'assets/images/$imageName.png';
}

class OnBoardModels {
  static final List<OnBoardModel> onboardItems = [
    OnBoardModel('Order Your Food', 'Now you can order food any time right from your mobile', 'ic_chef'),
    OnBoardModel('Order Your Food', 'Now you can order food any time right from your mobile', 'ic_delivery'),
    OnBoardModel('Order Your Food', 'Now you can order food any time right from your mobile', 'ic_order')
  ];
}
