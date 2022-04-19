import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SimplePanelParentData extends ContainerBoxParentData<RenderBox> {}

class SimplePanel extends MultiChildRenderObjectWidget {
  SimplePanel({
      Key? key, 
      List<Widget> children = const <Widget>[]
    }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSimplePanel();
  }
}

class RenderSimplePanel extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SimplePanelParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SimplePanelParentData> {

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! SimplePanelParentData) {
      child.parentData = SimplePanelParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    double maxWidth = 0.0;
    double maxHeight = 0.0;

    while (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);

      maxWidth = math.max(maxWidth, child.size.width);
      maxHeight = math.max(maxHeight, child.size.height);

      final SimplePanelParentData childParentData = child.parentData! as SimplePanelParentData;
      child = childParentData.nextSibling;
    }

    size = Size(maxWidth, maxHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
