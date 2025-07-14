import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "../../../config"
import "../../../widgets"

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
      text: {
        if (root.sink?.audio.muted) {
          return "volume_off";
        }

        if (root.volume == 0) {
          return "volume_mute";
        }

        if (root.volume <= 50) {
          return "volume_down";
        }

        return "volume_up";
      }
      color: Appearance.color.text
      fill: 1
    }
  }
}
