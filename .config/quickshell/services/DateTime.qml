pragma Singleton

import Quickshell

Singleton {
  property string time: Qt.formatDateTime(clock.date, "hh:mm")

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
