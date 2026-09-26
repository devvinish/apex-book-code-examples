// Push notifications are off in the API Lab (Shared Components > Progressive Web App).
console.log("subscribed:", await apex.pwa.hasPushSubscription());
console.log("subscription:", await apex.pwa.getPushSubscription());
console.log("subscribePushNotifications returned:", await apex.pwa.subscribePushNotifications());
console.log("subscribed:", await apex.pwa.hasPushSubscription());
