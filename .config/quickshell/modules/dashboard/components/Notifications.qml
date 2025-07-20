import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.widgets

Item {
  implicitHeight: layout.implicitHeight
  Layout.fillWidth: true

  Rectangle {
    color: Appearance.color.crust
    radius: 8
    anchors.fill: parent
  }

  ColumnLayout {
    id: layout

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 0

    Item {
      Layout.fillWidth: true
      implicitHeight: row.implicitHeight + 24

      Rectangle {
        color: Appearance.color.mantle
        anchors.fill: parent
        topLeftRadius: 8
        topRightRadius: 8
      }

      RowLayout {
        id: row

        spacing: 8
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12

        MaterialIcon {
          text: "notifications"
          color: Appearance.color.text
        }

        TextNormal {
          text: `Notifications ${Notifications.groups.length > 0 ? "(" + Notifications.groups.length + ")" : ""}`
        }

        HorizontalSpacer {}

        // TODO: turn into a button to enable/disable popups.
        TextNormal {
          text: "Popups OFF"
          color: Appearance.color.subtext1
        }
      }
    }

    ColumnLayout {
      Layout.margins: 12
      spacing: 8

      TextNormal {
        text: "All caught up."
        visible: Notifications.groups.length == 0
      }

      Repeater {
        model: Notifications.groups

        Notification {
          required property Notifications.NotificationGroup modelData
          group: modelData
        }
      }
    }
  }
}
