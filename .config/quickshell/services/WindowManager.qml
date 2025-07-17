pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
  id: root

  component Window: QtObject {
    id: item

    property string name
    property bool visible: false
    property QsWindow window

    function show() {
      visible = true;
    }

    function hide() {
      visible = false;
    }

    function toggle(exclusive = true) {
      visible = !visible;

      if (visible && exclusive) {
        root.hideAll([name]);
      }

      return visible;
    }
  }

  property Window dashboard: Window {
    name: "dashboard"
  }

  property Window spotify: Window {
    name: "spotify"
  }

  property var bars: []
  property var windows: [dashboard, spotify]

  function hideAll(exclude = []) {
    for (const window of windows) {
      if (exclude.includes(window.name) || !window.visible) {
        continue;
      }

      window.hide();
    }
  }
}
