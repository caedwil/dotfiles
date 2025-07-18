import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "./components"
import qs.config
import qs.services
import qs.widgets

// TODO: Setup a mouse area covering the bar to handle dismissing active windows
// on click outside.
Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow { // qmllint disable
      id: root

      Component.onCompleted: {
        WindowManager.bars.push(root);
      }

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
            // TODO: This only works while the player is the first item in the layout.
            Position.setPlayerX(root.monitor, x - (spotify.width / 4));
          }

          Group {
            Volume {}
          }

          Group {
            Tray {}
          }

          Group {
            Clock {}
          }

          Group {
            decorations: false
            DashboardButton {}
          }
        }
      }
    }
  }
}
