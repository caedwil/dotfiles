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
    anchors.right: root.right
    anchors.bottom: root.bottom

    TextNormal {
      text: {
        const cpu = Math.round(Hardware.cpuUsage * 100);
        return `${cpu}%`;
      }
    }

    MaterialIcon {
      text: "memory"
      color: Appearance.color.text
      fill: 1
    }
  }
}
