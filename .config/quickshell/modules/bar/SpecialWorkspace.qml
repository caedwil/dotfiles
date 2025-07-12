import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland
import "../../config"
import "../../widgets"

Item {
  id: root

  Layout.fillHeight: true
  implicitWidth: layout.implicitWidth

  RowLayout {
    id: layout

    spacing: Appearance.bar.spacing

    anchors {
      top: parent.top
      bottom: parent.bottom
      topMargin: Appearance.bar.spacing
      bottomMargin: Appearance.bar.spacing
    }

    Button {
      id: button

      Layout.fillHeight: true
      implicitWidth: height

      hoverEnabled: true

      background: Rectangle {
        id: background

        radius: 999

        color: {
          if (button.hovered) {
            return Appearance.color.surface0;
          }

          return Appearance.color.base;
        }
      }

      onPressed: Hyprland.dispatch("togglespecialworkspace")

      TextNormal {
        id: text
        text: "?"
        anchors.centerIn: parent
        opacity: 0.5
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: event => event.accepted = false
      }
    }
  }
}
