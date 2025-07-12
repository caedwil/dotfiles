pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland
import "../../config"
import "../../services"
import "../../widgets"

Button {
  id: root

  required property HyprlandWorkspace workspace
  required property HyprlandMonitor monitor
  property var clients: HyprlandExtended.clientsForWorkspaceByClass(workspace)
  property var hasClients: clients.length > 0

  Layout.fillHeight: true
  implicitWidth: root.hasClients ? layout.implicitWidth : height

  hoverEnabled: true

  background: Rectangle {
    id: background

    radius: 999

    color: {
      if (root.workspace?.id == root.monitor?.activeWorkspace?.id || root.hovered) {
        return Appearance.color.surface0;
      }

      return Appearance.color.base;
    }
  }

  onPressed: root.workspace.activate()

  TextNormal {
    visible: !root.hasClients
    text: '+'
    anchors.centerIn: parent
    opacity: 0.5
  }

  RowLayout {
    id: layout

    spacing: 0

    anchors {
      top: parent.top
      bottom: parent.bottom
    }

    Repeater {
      model: root.clients

      Item {
        id: client
        required property var modelData

        Layout.fillHeight: true
        implicitWidth: height

        TextNormal {
          // TODO: replace with the application's icon.
          text: client.modelData.class[0].toLowerCase()
          anchors.centerIn: parent
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onPressed: event => event.accepted = false
  }
}
