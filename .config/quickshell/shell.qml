//@ pragma UseQApplication

import Quickshell
import qs.modules.bar
import qs.modules.dashboard as Dashboard
import qs.modules.player

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
}
