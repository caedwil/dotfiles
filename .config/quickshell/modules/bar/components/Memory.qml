import QtQuick
import QtQuick.Layouts
import "../../../config"
import "../../../services"
import "../../../widgets"

Item {
  id: root

  Layout.fillHeight: true
  implicitWidth: layout.implicitWidth + Appearance.bar.padding

  RowLayout {
    id: layout

    anchors.top: root.top
    anchors.left: root.left
    anchors.bottom: root.bottom

    TextNormal {
      text: {
        const memoryUsage = Math.round(Hardware.memoryUsage * 100);
        return `${memoryUsage}%`;
      }
    }

    MaterialIcon {
      text: "memory_alt"
      color: Appearance.color.text
      fill: 1
    }
  }
}
