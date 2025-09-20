pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  readonly property list<NotificationGroup> groups: []

  function init(): void {
  }

  NotificationServer {
    actionIconsSupported: false
    actionsSupported: true
    bodyHyperlinksSupported: true
    bodyImagesSupported: false
    bodyMarkupSupported: true
    bodySupported: true
    imageSupported: false
    keepOnReload: false
    persistenceSupported: false

    onNotification: notification => {
      notification.tracked = true;

      const id = notification.appName + ":" + notification.summary;
      let group = root.groups.find(group => group.id == id);

      if (!group) {
        root.groups.push(groupComponent.createObject(root, {}));
        group = root.groups[root.groups.length - 1];
      }

      group.add(notification);
    }
  }

  Component {
    id: groupComponent

    NotificationGroup {}
  }

  // TODO: popups.
  // TODO: popup toggle.
  // TODO: temporarily disable popups when the dashboard is open.
  // TODO: transient overrides - for Spotify, specifically.
  // TODO: accordion.
  // TODO: unread notification dot. Show on button in bar.
  component NotificationGroup: QtObject {
    id: group

    property list<Notification> notifications: []

    property string id: group.appName + ":" + group.summary
    property string summary: notifications[0].summary
    property string appName: notifications[0].appName
    property date timestamp: new Date()
    property int elapsedInSeconds

    readonly property Timer timer: Timer {
      interval: 5000
      repeat: true
      running: true

      onTriggered: {
        group.updateElapsedInSeconds();
      }
    }

    function add(notification: Notification) {
      group.notifications.push(notification);
      notification.closed.connect(() => {
        group.notifications = group.notifications.filter(({
            id
          }) => id != notification.id);
      });
    }

    function dismiss() {
      for (const notification of notifications) {
        notification.dismiss();
      }

      root.groups = root.groups.filter(item => item.id != group.id);
    }

    function updateElapsedInSeconds() {
      group.elapsedInSeconds = (Date.now() - group.timestamp.getTime()) / 1000;
    }

    function updateTimestamp() {
      group.timestamp = new Date();
      group.updateElapsedInSeconds();
    }

    onNotificationsChanged: {
      if (notifications.length == 0) {
        dismiss();
        return;
      }

      updateTimestamp();
    }

    onSummaryChanged: {
      updateTimestamp();
    }
  }
}
