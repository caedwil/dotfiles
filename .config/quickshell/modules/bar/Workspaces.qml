pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../config"

Item {
  id: root

  required property var screen
  property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

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
      model: Hyprland.workspaces.values.filter(workspace => workspace.monitor?.id == monitor?.id && !workspace.name?.startsWith('special:'))

      Workspace {
        required property var modelData
        workspace: modelData
        monitor: root.monitor
      }
    }
  }
}
