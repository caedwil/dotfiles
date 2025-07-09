//@ pragma UseQApplication

import Quickshell
import "./widgets/bar"

ShellRoot {
  LazyLoader {
    active: true
    component: BarWidget {}
  }
}
