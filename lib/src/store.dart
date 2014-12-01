part of deluxjs;

class Store {
  List subscriptions;

  Store([Function init, List listenables]) {
    this.subscriptions = [];
    this._emitter = new EventEmitter();
    this.eventLabel = "change";
    if (init != null) {
      init();
    }
    if (listenables != null) {
      for (var listenable in listenables) {
        this.listenToMany(listenable);
      }
    }
  }

  bool hasListener (var listenable) {
    var listener, listenables;
    for (var sub in subscriptions) {
      listenables = sub.listenable;
      for (var item in listenables) {
        listener = item;
        if (listener == listenable || listener.hasListener && listener.hasListener(listenable)) {
          return true;
        }
      }
    }
    return false;
  }

  void listenToMany (List listenables){
    for(var key in listenables){
      var cbname = _.callbackName(key),
      localname = this[cbname] ? cbname : this[key] ? key : undefined;
      if (localname){
        this.listenTo(listenables[key],localname,this[cbname+"Default"]||this[localname+"Default"]||localname);
      }
    }
  }
}