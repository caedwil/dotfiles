import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../../../common/format.js" as Format
import "../../../config"
import "../../../widgets"

// TODO: Add scrubbing.
Item {
  id: root

  required property MprisPlayer player

  Layout.fillWidth: true
  implicitHeight: layout.implicitHeight

  RowLayout {
    id: layout

    spacing: 8
    anchors.fill: parent

    TextNormal {
      text: Format.seconds(root.player.position)
    }

    ClippingRectangle {
      id: bar

      radius: Appearance.radius.full
      Layout.fillWidth: true
      implicitHeight: 8

      Rectangle {
        color: Appearance.color.crust
        anchors.fill: parent
      }

      Rectangle {
        color: Appearance.color.text
        radius: Appearance.radius.full
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        implicitWidth: bar.width * (root.player.position / root.player.length)
      }
    }

    TextNormal {
      text: Format.seconds(root.player.length)
    }
  }
}
