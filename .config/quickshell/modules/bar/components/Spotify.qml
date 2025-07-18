pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import qs.config
import qs.services
import qs.widgets

Item {
  id: root
  property MprisPlayer player: Media.getPlayerByName("Spotify")

  Layout.fillHeight: true
  implicitWidth: (root.player ? 320 : layout.implicitWidth) + (Appearance.bar.padding * 2)

  RowLayout {
    id: layout

    spacing: Appearance.bar.tray.spacing
    anchors.fill: parent
    anchors.leftMargin: Appearance.bar.padding
    anchors.rightMargin: Appearance.bar.padding

    MaterialIcon {
      text: root.player?.isPlaying ? "pause" : "play_arrow"
      color: Appearance.color.text
      fill: 1
      visible: root.player

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        onClicked: event => {
          event.accepted = true;

          if (event.button != Qt.LeftButton || !root.player) {
            return;
          }

          root.player.togglePlaying();
        }
      }
    }

    TextNormal {
      text: root.player ? root.player?.trackArtist + " - " + root.player?.trackTitle : ""
      elide: Text.ElideRight
      Layout.fillWidth: true

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        onClicked: event => {
          event.accepted = true;

          if (!root.player) {
            Hyprland.dispatch("exec spotify-launcher");
            return;
          }

          Hyprland.dispatch("global quickshell:player-spotify-toggle-anchor-to-bar");
        }
      }
    }
  }
}
