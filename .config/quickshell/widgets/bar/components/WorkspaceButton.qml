import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland
import "../../../common"

Button {
  id: root

  required property HyprlandWorkspace workspace
  required property HyprlandMonitor monitor

  Layout.fillHeight: true
  implicitWidth: height

  hoverEnabled: true

  background: Rectangle {
    id: background

    radius: 4

    color: {
      if (root.workspace.id == root.monitor.activeWorkspace.id || root.hovered) {
        return Appearance.color.base;
      }

      return 'transparent';
    }
  }

  onPressed: root.workspace.activate()

  // TODO: use icons instead.
  TextRegular {
    text: root.workspace.id
    anchors.centerIn: parent
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onPressed: event => event.accepted = false
  }
}
