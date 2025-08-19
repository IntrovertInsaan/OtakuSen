import consumer from "./consumer"

consumer.subscriptions.create("ForumThreadChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Successfully connected to the ForumThreadChannel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the WebSocket for this channel.
    // Turbo Streams handles this automatically, so this can be empty.
  }
});
