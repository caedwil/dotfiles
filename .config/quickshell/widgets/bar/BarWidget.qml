import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../common"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow { // qmllint disable
      id: root

      property var modelData
      screen: modelData

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

          BarGroupWidget {
            padding: Appearance.bar.spacing

            WorkspacesWidget {
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

          BarGroupWidget {
            SpotifyWidget {}
          }

          BarGroupWidget {
            SystemTrayWidget {}
          }

          BarGroupWidget {
            ClockWidget {}
          }
        }
      }
    }
  }
}
