import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.widgets

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
        const memoryUsage = Math.round(SystemInfo.memoryUsage * 100);
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
