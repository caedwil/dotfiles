pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Wayland
import "./components"
import "../../config"
import "../../widgets"

PanelWindow { // qmllint disable
  id: root

  required property string name

  color: "transparent"

  implicitHeight: player.implicitHeight
  implicitWidth: player.implicitWidth

  anchors.top: true

  WlrLayershell.layer: WlrLayer.Overlay

  mask: Region {
    item: player
  }

  exclusionMode: ExclusionMode.Normal

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
          if (modelData.identity == root.name) {
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
      implicitWidth: player.implicitWidth - 16
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

    ColumnLayout {
      id: layout

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.margins: 20

      spacing: 12

      RowLayout {
        spacing: 8

        AlbumArtwork {
          id: artwork
          player: player.player
        }

        ColumnLayout {
          TextLarge {
            text: player.player?.trackTitle
            elide: Text.ElideRight
            font.bold: true
            Layout.maximumWidth: player.width - controls.width - artwork.width - 40 - 24
          }

          TextNormal {
            text: player.player?.trackArtist
            elide: Text.ElideRight
            Layout.maximumWidth: player.width - controls.width - artwork.width - 40 - 24
          }
        }

        HorizontalSpacer {}

        Controls {
          id: controls
          player: player.player
          Layout.alignment: Qt.AlignHCenter
        }
      }

      Rectangle {
        color: Appearance.color.crust
        implicitHeight: 1
        Layout.fillWidth: true

        Layout.leftMargin: -12
        Layout.rightMargin: -12
      }

      ProgressBar {
        player: player.player
      }
    }
  }
}
