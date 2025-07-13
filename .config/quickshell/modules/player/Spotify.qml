pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../../config"
import "../../widgets"

// TODO: Make Appearance.player.spotify.
Scope {
  id: scope

  GlobalShortcut {
    name: "player-spotify-toggle"
    onPressed: loader.active = !loader.active
  }

  LazyLoader {
    id: loader
    active: false

    // TODO: Move into a separate file.
    // TODO: To set the position, have the Spotify bar component "broadcast" its
    //       position so that we can use it.
    PanelWindow {
      id: window

      color: "transparent"

      implicitHeight: player.implicitHeight
      implicitWidth: player.implicitWidth

      anchors.top: true
      anchors.right: true
      margins.top: 0
      margins.right: 0

      mask: Region {
        item: player
      }

      Item {
        id: player
        implicitHeight: layout.implicitHeight + 40
        implicitWidth: 512

        property MprisPlayer player: null

        Instantiator {
          model: Mpris.players

          Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: {
              if (modelData.identity == "Spotify") {
                player.player = target;
              }
            }
          }
        }

        FrameAnimation {
          running: player.player?.playbackState == MprisPlaybackState.Playing
          onTriggered: player.player.positionChanged()
        }

        Rectangle {
          id: background
          implicitHeight: player.implicitHeight - 16
          implicitWidth: 512 - 16
          anchors.centerIn: parent
          color: Appearance.color.base
          border.color: Appearance.color.crust
          radius: 8
        }

        MultiEffect {
          source: background
          anchors.fill: background
          shadowEnabled: true
          shadowBlur: 0.4
          shadowColor: Appearance.color.crust
          shadowVerticalOffset: 0
          shadowHorizontalOffset: 0
        }

        RowLayout {
          id: layout

          anchors.top: parent.top
          anchors.left: parent.left
          anchors.margins: 20

          spacing: 8

          ClippingWrapperRectangle {
            radius: 4

            Image {
              source: player.player?.trackArtUrl.toString()
              sourceSize: Qt.size(96, 96)
            }
          }

          ColumnLayout {
            Layout.alignment: Qt.AlignTop

            // TODO: bigger text - TextLarge?
            TextNormal {
              text: player.player?.trackTitle
              font.pixelSize: 16
              font.bold: true
            }

            TextNormal {
              text: player.player?.trackArtist
            }

            Item {
              Layout.fillHeight: true
            }

            TextNormal {
              // TODO: move this into a helper function file?
              function format(value) {
                const m = Math.floor(value / 60.0);
                const s = Math.floor(value % 60.0);
                return `${m}:${s < 10 ? '0' : ''}${s}`;
              }

              text: `${format(player.player?.position)} / ${format(player.player?.length)}`
            }

            // TODO: play/pause.
            // TODO: next.
            // TODO: previous.
            // TODO: progress bar.
          }
        }
      }
    }
  }
}
