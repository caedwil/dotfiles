pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config"
import "../../services"

// TODO: Split up into smaller components.
// TODO: Add a button to the workspace selector in the status bar that opens this?
// TODO: Should it try to place itself _over_ fullscreen apps?
Scope {
  id: scope

  property bool isOpen: false

  GlobalShortcut {
    name: "workspace-switcher-toggle"
    onPressed: {
      scope.isOpen = !scope.isOpen;
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow { // qmllint disable
      id: root
      required property ShellScreen modelData
      screen: modelData

      color: "transparent"

      visible: scope.isOpen

      anchors.top: true
      anchors.left: true
      anchors.right: true
      anchors.bottom: true

      property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

      HyprlandFocusGrab {
        id: grab
        windows: [root]
        active: scope.isOpen && root.monitor.id === Hyprland.focusedMonitor.id
      }

      property var clients: HyprlandExtended.clients
      property var workspaces: HyprlandExtended.workspaces
      property var workspacesForMonitor: root.workspaces.filter(workspace => workspace.monitorID === monitor.id && !workspace.name.startsWith("special:"))

      // TODO: calculate based on monitor width and desired size of items.
      property var columns: 3
      property var rows: 0

      onWorkspacesForMonitorChanged: {
        root.rows = Math.ceil(root.workspacesForMonitor.length / columns);
      }

      Rectangle {
        color: Appearance.color.crust
        anchors.fill: parent
        opacity: 0.5
      }

      ColumnLayout {
        id: layout
        spacing: 8

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        focus: true

        Keys.onEscapePressed: {
          scope.isOpen = false;
        }

        Repeater {
          model: root.rows

          RowLayout {
            id: row
            required property real modelData

            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            Repeater {
              model: {
                const start = row.modelData * root.columns;
                const end = Math.min(start + root.columns, root.workspacesForMonitor.length);
                return root.workspacesForMonitor.slice(start, end);
              }

              Item {
                id: item

                required property var modelData

                // TODO: make this a configurable property.
                // TODO: padding is a bit weird on the ultrawide for some reason.
                property var padding: 0

                // TODO: derive from `hyprctl monitors`.
                property var reserved: 0

                // TODO: derive from desired rows/cols and the monitor dimensions.
                implicitHeight: 256 + padding
                implicitWidth: (implicitHeight - padding) * (root.monitor.width / (root.monitor.height - reserved)) + padding

                Rectangle {
                  id: background
                  color: Appearance.color.crust
                  border.color: Appearance.color.surface0
                  anchors.fill: parent

                  Behavior on border.color {
                    ColorAnimation {
                      duration: 80
                    }
                  }
                }

                DropShadow {
                  id: backgroundShadow
                  source: background
                  anchors.fill: background
                  color: Appearance.color.crust
                  radius: 4
                  samples: 9
                  verticalOffset: 0
                  horizontalOffset: 0
                }

                Text {
                  id: text
                  text: parent.modelData.id
                  color: Appearance.color.text
                  font.family: Appearance.font.family.normal
                  font.pixelSize: 64
                  anchors.centerIn: parent
                  z: 2
                }

                DropShadow {
                  source: text
                  anchors.fill: text
                  color: Appearance.color.base
                  radius: 0
                  verticalOffset: 2
                  horizontalOffset: 2
                  z: 1
                }

                MouseArea {
                  id: mouseArea
                  acceptedButtons: Qt.LeftButton
                  anchors.fill: parent
                  hoverEnabled: true
                  cursorShape: Qt.PointingHandCursor
                  onEntered: () => {
                    background.border.color = Appearance.color.mauve;
                  }
                  onExited: () => {
                    background.border.color = Appearance.color.surface0;
                  }
                  onPressed: event => {
                    Hyprland.dispatch(`workspace ${parent.modelData.id}`);
                    scope.isOpen = false;
                    event.accepted = true;
                  }
                }

                Repeater {
                  model: ToplevelManager.toplevels.values.filter(toplevel => {
                    const address = `0x${toplevel.HyprlandToplevel.address}`;
                    const client = root.clients.find(client => client.address === address);
                    return client && client.workspace.id === parent.modelData.id;
                  })

                  Item {
                    required property Toplevel modelData

                    property var address: `0x${modelData.HyprlandToplevel.address}`
                    property var client: root.clients.find(client => client.address === address)

                    implicitWidth: client.size[0] / root.monitor.width * (item.implicitWidth - item.padding - 2)
                    implicitHeight: client.size[1] / (root.monitor.height - item.reserved) * (item.implicitHeight - item.padding - 2)

                    x: (client.at[0] - root.monitor.x + (item.padding * 2)) / root.monitor.width * (item.implicitWidth - item.padding) + 1
                    y: (client.at[1] - item.reserved + (item.padding * 2)) / (root.monitor.height - item.reserved) * (item.implicitHeight - item.padding) + 1

                    ScreencopyView {
                      live: true
                      captureSource: parent.modelData
                      anchors.fill: parent
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
