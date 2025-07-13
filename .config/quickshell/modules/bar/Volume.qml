import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../../config"
import "../../widgets"

Item {
  id: root

  property PwNode sink: Pipewire.defaultAudioSink
  property real volume: ((sink?.audio.volume ?? 0) * 100.0).toFixed(0)

  Layout.fillHeight: true
  implicitWidth: layout.implicitWidth + Appearance.bar.padding

  PwObjectTracker {
    objects: [root.sink]
  }

  RowLayout {
    id: layout
    anchors.centerIn: parent

    TextNormal {
      text: `${root.volume}%`
    }

    MaterialIcon {
      text: !root.sink?.audio.muted ? "volume_up" : "volume_off"
      color: Appearance.color.text
      fill: 1
    }
  }
}
