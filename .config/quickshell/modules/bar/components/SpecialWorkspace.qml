import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../config"
import "../../../services"

Item {
  Layout.fillHeight: true
  implicitWidth: workspace.implicitWidth

  Layout.topMargin: Appearance.bar.spacing
  Layout.bottomMargin: Appearance.bar.spacing

  Workspace {
    id: workspace
    anchors.fill: parent
    workspace: HyprlandExtended.workspaces.find(workspace => workspace.name == "special:special")
    onPressed: Hyprland.dispatch(`togglespecialworkspace special`)
  }
}
