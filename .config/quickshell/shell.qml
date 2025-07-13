//@ pragma UseQApplication

import Quickshell
import "./modules/bar"
import "./modules/workspace_switcher"

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
