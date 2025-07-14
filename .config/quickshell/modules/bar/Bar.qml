import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "./components"
import "../../config"
import "../../services"
import "../../widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow { // qmllint disable
      id: root

      property var modelData
      screen: modelData

      property var monitor: Hyprland.monitorFor(screen)

      anchors.top: true
      anchors.left: true
      anchors.right: true

      // +1 for the bottom border.
      implicitHeight: 48 + 1
      color: "transparent"

      Item {
        // -1 to let the bottom border show.
        height: parent.height - 1

        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
        }

        Rectangle {
          anchors.fill: parent
          color: Appearance.bar.background.color
        }

        Border {
          color: Appearance.bar.border.color
          bottomWidth: 1
        }

        RowLayout {
          spacing: Appearance.bar.spacing

          anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            margins: Appearance.bar.spacing
          }

          Group {
            padding: Appearance.bar.spacing

            Workspaces {
              monitor: root.monitor
            }

            Rectangle {
              color: Appearance.bar.group.border.color
              Layout.fillHeight: true
              implicitWidth: 1
            }

            SpecialWorkspace {}
          }

          Group {
            decorations: false

            Activity {
              screen: root.screen
            }
          }
        }

        RowLayout {
          spacing: Appearance.bar.spacing

          anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            margins: Appearance.bar.spacing
          }

          Group {
            Spotify {
              id: spotify
            }
          }

          onXChanged: {
            Position.setPlayerX(root.monitor, x - (spotify.width / 4));
          }

          Group {
            Volume {}
          }

          Group {
            CPU {}
            Memory {}
          }

          Group {
            Tray {}
          }

          Group {
            Clock {}
          }
        }
      }
    }
  }
}
