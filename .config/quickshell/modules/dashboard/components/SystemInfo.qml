import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.widgets
import "../../../common/prettify.js" as Prettify

Item {
  implicitHeight: layout.implicitHeight + 24
  Layout.fillWidth: true

  Rectangle {
    color: Appearance.color.mantle
    radius: 8
    anchors.fill: parent
  }

  RowLayout {
    id: layout

    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.rightMargin: 12

    spacing: 12

    TextNormal {
      text: `Uptime: ${Prettify.seconds(SystemInfo.uptimeInSeconds, {
        condensed: false,
        seconds: false
      })}`
    }

    HorizontalSpacer {}

    RowLayout {
      TextNormal {
        id: text
        text: {
          const cpu = Math.round(SystemInfo.cpuUsage * 100);
          return `${cpu}%`;
        }
      }

      MaterialIcon {
        text: "memory"
        color: Appearance.color.text
        fill: 1
      }
    }

    RowLayout {
      TextNormal {
        text: {
          const memoryUsage = Math.round(SystemInfo.memoryUsage * 100);
          return `${memoryUsage}%`;
        }
      }

      MaterialIcon {
        text: "memory_alt"
        color: Appearance.color.text
        fill: 1
      }
    }
  }
}
