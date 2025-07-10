import QtQuick
import QtQuick.Layouts
import "../../../config"

Item {
  property real padding: Appearance.bar.padding

  Layout.fillHeight: true
  implicitWidth: layout.implicitWidth + (padding * 2)

  default property alias items: layout.children

  Rectangle {
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
