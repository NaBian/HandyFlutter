import 'dart:convert';
import 'dart:ui';

import 'package:handycontrol/handycontrol.dart';
import 'package:handycontrol_example/demo_item.dart';
import 'demo_info.dart';

void main() {
  runApp(const HandyDemoApp());
}

class HandyDemoApp extends StatelessWidget {
  const HandyDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(window),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: _buildMainWindowContent(context),
      ),
    );
  }

  Widget _buildMainWindowContent(BuildContext context) {
    return SimplePanel(children: [
      Container(
        color: const Color(0xffeeeeee),
      ),
      Opacity(
        opacity: 0.1,
        child: SizedBox.expand(
          child: Image.asset(
            "assets/images/cloud.png",
            repeat: ImageRepeat.repeat,
            alignment: Alignment.topLeft,
          ),
        ),
      ),
      _buildLeftMainContent(context),
    ]);
  }

  Widget _buildLeftMainContent(BuildContext context) {
    return Container(
      width: 224,
      margin: const EdgeInsets.all(16),
      child: _buildDemoInfos(context),
      decoration: const BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 8))
          ]),
    );
  }

  Widget _buildDemoInfos(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/DemoInfo.json'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
          Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: snapshot.hasData
              ? DemoInfo.fromJson(
                      List.from(jsonDecode(snapshot.requireData)).first)
                  .demoItems
                  .map((demoItem) => DemoItemButton(demoItem))
                  .toList()
              : [],
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

class DemoItemButton extends StatefulWidget {
  final DemoItem demoItem;

  const DemoItemButton(this.demoItem, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemoItemStatus();
  }
}

class _DemoItemStatus extends State<DemoItemButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    DemoItem demoItem = (context.widget as DemoItemButton).demoItem;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: _isHover ? const Color(0xffeeeeee) : const Color(0xffffffff),
        borderRadius: const BorderRadius.all(Radius.circular(4))
      ),
      height: 30,
      child: MouseRegion(
        onHover: onHover,
        onExit: onExit,
        child: Row(
          children: [
            Image.asset(
                'assets/images/LeftMainContent/${demoItem.imageName}.png'),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                demoItem.name,
                style: const TextStyle(
                  color: Color(0xff000000),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onHover(PointerEvent details) {
    setState(() {
      _isHover = true;
    });
  }

  void onExit(PointerEvent details) {
    setState(() {
      _isHover = false;
    });
  }
}
