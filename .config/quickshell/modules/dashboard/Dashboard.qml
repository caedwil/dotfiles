pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.widgets
import "./components" as Components

// TODO: Do we want this panel on the left or on the right?
// TODO: Animate on opening the panel (and potentially on closing it).
ColumnLayout {
  id: layout
  spacing: 12

  anchors.centerIn: parent

  RowLayout {
    Layout.topMargin: 4
    Layout.leftMargin: 12
    Layout.rightMargin: 12
    Layout.bottomMargin: 4

    TextNormal {
      text: `${SystemInfo.username}@${SystemInfo.hostname} //`
    }

    Components.Clock {}

    HorizontalSpacer {}

    RowLayout {
      spacing: 12

      MaterialIconButton {
        text: "logout"
        color: hovered ? Appearance.color.accent : Appearance.color.text
        onPressed: logoutModal.active = !logoutModal.active
      }

      MaterialIconButton {
        text: "autorenew"
        color: hovered ? Appearance.color.accent : Appearance.color.text
        onPressed: rebootModal.active = !rebootModal.active
      }

      MaterialIconButton {
        text: "power_settings_new"
        color: hovered ? Appearance.color.accent : Appearance.color.text
        onPressed: shutdownModal.active = !shutdownModal.active
      }
    }
  }

  Components.SystemInfo {}

  Components.Notifications {}

  LazyLoader {
    id: logoutModal
    active: false

    ConfirmationModal {
      content: "Are you sure you want to logout?"
      confirmButtonContent: "Logout"

      onCancel: logoutModal.active = false
      onConfirm: Quickshell.execDetached(["loginctl", "terminate-user"])
    }
  }

  LazyLoader {
    id: rebootModal
    active: false

    ConfirmationModal {
      content: "Are you sure you want to reboot?"
      confirmButtonContent: "Reboot"

      onCancel: rebootModal.active = false
      onConfirm: Quickshell.execDetached(["systemctl", "reboot"])
    }
  }

  LazyLoader {
    id: shutdownModal
    active: false

    ConfirmationModal {
      content: "Are you sure you want to shutdown?"
      confirmButtonContent: "Shutdown"

      onCancel: shutdownModal.active = false
      onConfirm: Quickshell.execDetached(["systemctl", "poweroff"])
    }
  }
}
