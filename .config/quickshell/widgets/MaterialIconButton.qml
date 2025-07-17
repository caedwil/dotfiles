import QtQuick
import QtQuick.Controls

Item {
  id: root

  property alias text: icon.text
  property alias color: icon.color
  property alias size: icon.size
  property alias fill: icon.fill
  property alias weight: icon.weight

  signal pressed

  readonly property alias hovered: button.hovered

  implicitHeight: icon.height
  implicitWidth: icon.width

  Button {
    id: button

    background: null
    anchors.fill: parent

    MaterialIcon {
      id: icon

      Behavior on color {
        ColorAnimation {
          duration: 200
        }
      }
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onPressed: event => event.accepted = false
    }
  }

  Connections {
    target: button

    function onPressed() {
      root.pressed();
    }
  }
}
