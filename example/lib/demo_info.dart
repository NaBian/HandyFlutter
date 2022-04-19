import 'demo_item.dart';

class DemoInfo {
  String title = '';
  List<DemoItem> demoItems = List.empty();

  DemoInfo();

  factory DemoInfo.fromJson(dynamic json) {
    var demoInfo = DemoInfo();
    demoInfo.title = json['title'] as String;
    List<dynamic> dataList = json['demoItemList'];
    demoInfo.demoItems = dataList.map((data) => DemoItem.fromJson(data)).toList();

    return demoInfo;
  }
}