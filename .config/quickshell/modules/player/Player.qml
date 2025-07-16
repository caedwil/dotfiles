pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.services
import "./components"
import "../../config"
import "../../widgets"

ColumnLayout {
  id: root

  required property string name
  property MprisPlayer player: MprisController.getPlayerByName(name)

  FrameAnimation {
    running: root.player?.playbackState == MprisPlaybackState.Playing
    onTriggered: root.player.positionChanged()
  }

  spacing: 12

  RowLayout {
    spacing: 8

    AlbumArtwork {
      id: artwork
      player: root.player
    }

    ColumnLayout {
      TextLarge {
        text: root.player?.trackTitle
        elide: Text.ElideRight
        font.bold: true
        Layout.maximumWidth: root.width - controls.width - artwork.width - 40 - 24
      }

      TextNormal {
        text: root.player?.trackArtist
        elide: Text.ElideRight
        Layout.maximumWidth: root.width - controls.width - artwork.width - 40 - 24
      }
    }

    HorizontalSpacer {}

    Controls {
      id: controls
      player: root.player
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
    player: root.player
  }
}
