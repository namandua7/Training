// App.blog = App.cable.subscriptions.create("BlogsChannel", {
//   connected: function() {
//     console.log("Action Cable connected!");
//   },
//   disconnected: function() {
//     console.log("Action Cable disconnected!");
//   },
//   rejected: function() {
//     console.log("Action Cable connection rejected!");
//   },
//   received: function(data) {
//     console.log("Received data from Action Cable:", data);
//     // Handle received data
//   }
// });