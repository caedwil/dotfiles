import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../../../common/prettify.js" as Prettify
import "../../../common/math.js" as MathExtended
import qs.config
import qs.widgets

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
      text: Prettify.seconds(root.player.position, {
        condensed: true
      })
    }

    ClippingRectangle {
      id: bar

      property bool isHovered: false
      property bool isScrubbing: false
      property real scrubPosition: 0

      radius: Appearance.radius.full
      Layout.fillWidth: true
      implicitHeight: 8

      color: Appearance.color.crust

      Rectangle {
        id: scrubber
        color: bar.isHovered ? '#8bd5ca' : Appearance.color.text
        radius: Appearance.radius.full
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        implicitWidth: bar.isScrubbing ? bar.scrubPosition : bar.width * (root.player.position / root.player.length)
      }

      MouseArea {
        function calcMultiplier(event) {
          const value = event.x / bar.width;
          return MathExtended.clamp(value, 0, 1);
        }

        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
          bar.isHovered = true;
        }
        onExited: {
          bar.isHovered = false;
        }
        onPressed: event => {
          bar.isScrubbing = true;
          bar.scrubPosition = bar.width * calcMultiplier(event);
        }
        onReleased: event => {
          bar.isScrubbing = false;
          root.player.position = root.player.length * calcMultiplier(event);
        }
        onPositionChanged: event => {
          if (!bar.isScrubbing) {
            return;
          }

          bar.scrubPosition = bar.width * calcMultiplier(event);
        }
      }
    }

    TextNormal {
      text: Prettify.seconds(root.player.length, {
        condensed: true
      })
    }
  }
}
