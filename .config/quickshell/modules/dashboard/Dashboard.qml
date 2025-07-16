import QtQuick.Layouts
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

    // TODO: Make the menu a module as it may end up getting used elsewhere.
    MaterialIcon {
      text: "power_settings_new"
      color: Appearance.color.text
    }
  }

  Components.SystemInfo {}

  Components.Notifications {}
}
