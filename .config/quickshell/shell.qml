//@ pragma UseQApplication

import Quickshell
import "./modules/bar"

ShellRoot {
  LazyLoader {
    active: true
    component: Bar {}
  }
}
