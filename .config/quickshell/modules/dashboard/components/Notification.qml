pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.config
import qs.services
import qs.widgets
import "../../../common/prettify.js" as Prettify

Item {
  id: root

  required property Notifications.NotificationGroup group

  implicitHeight: layout.implicitHeight + 24
  Layout.fillWidth: true

  Rectangle {
    id: background
    anchors.fill: parent
    color: Appearance.color.mantle
    radius: 8
  }

  RowLayout {
    id: layout

    anchors.fill: parent
    anchors.margins: 12
    spacing: 12

    ColumnLayout {
      spacing: 8
      Layout.preferredWidth: layout.width

      TextNormal {
        text: root.group.summary
        font.weight: 600
      }

      ColumnLayout {
        Repeater {
          model: root.group.notifications

          TextNormal {
            required property Notification modelData
            text: modelData.body
            wrapMode: Text.Wrap
            Layout.maximumWidth: layout.width
          }
        }
      }

      TextSmall {
        text: `${root.group.appName} • ${Prettify.seconds(root.group.elapsedInSeconds, {
          seconds: false
        })}`
        color: Appearance.color.subtext1
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.MiddleButton

    onEntered: {
      background.color = Appearance.color.base;
    }

    onExited: {
      background.color = Appearance.color.mantle;
    }

    onPressed: event => {
      if (event.button == Qt.MiddleButton) {
        root.group.dismiss();
        return;
      }
    }
  }
}
