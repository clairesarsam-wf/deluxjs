part of deluxjs;

class Action {
  String eventLabel;
  EventEmitter emitter;
  bool sync;

  Action({String eventLabel: "action", bool sync: false}) {
    this.eventLabel = eventLabel;
    this.emitter = new EventEmitter();
    this.sync = sync;

    Keep.createdActions.add(this);
  }

  /**
   * Action emulates a function
   */
  void call ([dynamic args]) {
    this.sync ? this.trigger(args) : this.triggerAsync(args);
  }

  /**
   * Publishes an event using `this.emitter`
   * Publish the event with the data passed through to trigger
   * Trigger only accepts one argument for now
   */
  void trigger (dynamic args) {
    this.emitter.emit(this.eventLabel, args);
  }

  /**
   * Tries to publish the event on the next tick
   * (actually right now does the same thing as trigger)
   */
  void triggerAsync (dynamic args) {
    this.emitter.emit(this.eventLabel, args);
  }

  /**
   * Subscribes the given callback for action triggered
   * Return a function that unsubscribes
   */
  Function listen (Function callback) {
    this.emitter.on(this.eventLabel, callback);
    return () {
      this.emitter.off(this.eventLabel, callback);
    };
  }
}