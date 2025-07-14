import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../../../config"

Item {
  id: root

  required property SystemTrayItem item

  Layout.fillHeight: true
  implicitWidth: icon.width
  visible: item.status != Status.Passive

  IconImage {
    id: icon
    source: root.item.icon
    height: Appearance.bar.tray.icon.size
    width: Appearance.bar.tray.icon.size
    anchors.centerIn: parent
  }

  QsMenuAnchor {
    id: menu
    menu: root.item.menu // qmllint disable

    anchor {
      item: icon
      adjustment: PopupAdjustment.FlipX // qmllint disable
      edges: Edges.Bottom | Edges.Left // qmllint disable
      rect {
        w: icon.width
        h: icon.height + 4
      }
    }
  }

  MouseArea {
    anchors.fill: icon
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: event => {
      event.accepted = true;

      if (event.button == Qt.LeftButton) {
        if (root.item.onlyMenu) {
          return;
        }

        root.item.activate();
        return;
      }

      if (event.button == Qt.RightButton) {
        if (!root.item.hasMenu) {
          return;
        }

        menu.open();
        return;
      }
    }
  }
}
