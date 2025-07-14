import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../../../config"

ClippingWrapperRectangle {
  id: root

  required property MprisPlayer player

  radius: 4
  color: Appearance.color.surface0
  implicitHeight: 48
  implicitWidth: 48

  Image {
    source: root.player.trackArtUrl.toString()
    sourceSize: Qt.size(48, 48)
  }
}
