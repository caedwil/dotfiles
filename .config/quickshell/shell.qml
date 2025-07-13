//@ pragma UseQApplication

import Quickshell
import "./modules/bar"
import "./modules/player"

ShellRoot {
  LazyLoader {
    active: true
    component: Bar {}
  }

  LazyLoader {
    active: true
    component: Spotify {}
  }
}
