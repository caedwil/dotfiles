pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import "../../config"
import "../../services"
import "../../widgets"

Button {
  id: root

  required property var workspace
  property HyprlandMonitor monitor
  property var clients: HyprlandExtended.clientsForWorkspaceByClass(workspace)
  property bool hasClients: clients.length > 0

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

  onPressed: {
    if (workspace.name.startsWith('special:')) {
      Hyprland.dispatch(`togglespecialworkspace ${workspace.name.substring('special:'.length)}`);
      return;
    }

    Hyprland.dispatch(`workspace ${workspace.id}`);
  }

  TextNormal {
    visible: !root.hasClients
    text: '+'
    anchors.centerIn: parent
    opacity: 0.5
  }

  RowLayout {
    id: layout

    spacing: 0
    anchors.fill: parent

    Repeater {
      model: root.clients

      Item {
        id: client

        required property var index
        required property var modelData
        property var desktopEntry: DesktopEntries.byId(modelData.class)

        Layout.fillHeight: true
        implicitWidth: height

        Layout.alignment: Qt.AlignLeft
        Layout.leftMargin: index == 0 ? 0 : -6

        Image {
          id: icon
          visible: client.desktopEntry
          source: Quickshell.iconPath(client.desktopEntry?.icon)
          anchors.centerIn: parent
          height: parent.height - 12
          width: parent.width - 12
          smooth: true
        }

        TextNormal {
          visible: !client.desktopEntry
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
