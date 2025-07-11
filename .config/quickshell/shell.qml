//@ pragma UseQApplication

import Quickshell
import "./modules/bar"
import "./modules/workspace-switcher"

ShellRoot {
  LazyLoader {
    active: true
    component: Bar {}
  }

  LazyLoader {
    active: true
    component: WorkspaceSwitcher {}
  }
}
