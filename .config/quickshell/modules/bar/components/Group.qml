import QtQuick
import QtQuick.Layouts
import qs.config

Item {
  id: root

  property real padding: Appearance.bar.padding
  property bool decorations: true

  Layout.fillHeight: true
  implicitWidth: layout.implicitWidth + (padding * 2) + 2

  default property alias items: layout.children

  Rectangle {
    visible: root.decorations
    color: Appearance.bar.group.color
    border.color: Appearance.bar.group.border.color
    radius: Appearance.bar.group.border.radius
    anchors.fill: parent
  }

  RowLayout {
    id: layout
    spacing: Appearance.bar.spacing
    anchors.centerIn: parent
    height: parent.height
  }
}
