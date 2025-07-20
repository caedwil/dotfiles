//@ pragma UseQApplication

import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.dashboard as Dashboard
import qs.modules.player

import qs.services

ShellRoot {
  LazyLoader {
    active: true
    component: Bar {}
  }

  LazyLoader {
    active: true
    component: Spotify {}
  }

  Dashboard.Window {}

  Component.onCompleted: {
    Notifications.init();
  }
}
