class DemoItem {
  String name = '';
  String imageName = '';

  DemoItem();

  factory DemoItem.fromJson(dynamic json) {
    var demoItem = DemoItem();
    List<dynamic> dataList = json;
    demoItem.name = dataList[0];
    demoItem.imageName = dataList[2];

    return demoItem;
  }
}