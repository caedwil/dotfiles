pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config
import qs.services

Item {
  id: root

  required property var monitor

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

    Repeater {
      model: HyprlandExtended.workspacesForMonitor(root.monitor)

      Workspace {
        required property var modelData
        workspace: modelData
        monitor: root.monitor
        onPressed: Hyprland.dispatch(`workspace ${workspace.id}`)
      }
    }
  }
}
