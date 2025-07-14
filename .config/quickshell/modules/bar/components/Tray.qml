import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import "../../../config"

Item {
  id: root

  implicitHeight: parent.implicitHeight
  implicitWidth: layout.implicitWidth + (Appearance.bar.padding * 2)

  RowLayout {
    id: layout

    spacing: Appearance.bar.tray.spacing
    anchors.centerIn: parent

    Repeater {
      model: SystemTray.items

      TrayItem {
        required property SystemTrayItem modelData
        item: modelData
      }
    }
  }
}
