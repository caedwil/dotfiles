import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.config
import qs.widgets

Item {
  id: root

  required property MprisPlayer player

  implicitHeight: layout.implicitHeight
  implicitWidth: layout.implicitWidth

  RowLayout {
    id: layout

    anchors.centerIn: parent

    MaterialIconButton {
      text: "skip_previous"
      color: Appearance.color.text
      size: 32
      fill: 1

      onPressed: root.player.previous()
    }

    MaterialIconButton {
      text: root.player.isPlaying ? "pause_circle" : "play_circle"
      color: Appearance.color.text
      size: 40
      fill: 1

      onPressed: root.player.togglePlaying()
    }

    MaterialIconButton {
      text: "skip_next"
      color: Appearance.color.text
      size: 32
      fill: 1

      onPressed: root.player.next()
    }
  }
}
