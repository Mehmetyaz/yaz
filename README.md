# yaz

Yaz Package for State, Content and User's Options Managements

# Introduction

This package is supported for Web, Mobile and Desktop applications.

Yaz Package is consisted of two parts;

#### 1) State Management

[Demo App Video](https://youtu.be/qyjq9laVdgE)

* Yaz Package is a state management package in the first place.  It uses only ``ChangeNotifier`` for the whole process, due to this it is really simple and fast.
  It uses only one widget. Widget of "YazListenerWidget"

* Yaz helps you to convert any objects to ``ChangeNotifier`` with a simple code.

* Yaz supports for collection changes both in separate or entirely.

#### 2) Content Management

* Yaz provides you to get and change user options by a simple code from any part of the application.

* Yaz helps you to store and cache your app's Frequently Used Contents.

# Usage

## How to Convert an Object to a Change Notifier?

Any object might be converted into a ``ChangeNotifier``: ``YazNotifier``

``.notifier`` works on any object and returns a ``YazNotifier``

````dart
    var counter = 0.notifier;
    var editing = "Mehmet Yaz".notifier; 
    var foo = Foo().notifier; 
````

``.value`` gets and set an value in ``YazNotifier`` instance;

This setter triggers all listeners

````dart
    print(counter.value);
    // output - 0 -
    
    counter.value++;
    
    print(counter.value);
    // output - 1 -
````

### _! Attention:_

If you wish to listen changes in instance members of ``foo`` :

````dart
    // DON'T
    var foo = Foo().notifier;
````

````dart
    // DO
    var bar = Foo().bar.notifier;
````

Because ``foo`` is triggered only like this;

````dart
    foo.value =  Foo(); // new instance
    foo.value = anotherFoo;
````

### BuiltNotifier
You can see the widgets wrapped by ``BuiltNotifier`` when they are rebuilt. They blink when they are rebuilt.
`````dart
  BuiltNotifier(
        child: YourWidget()
        );
`````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/single_changes.gif)

## YazListenerWidget

``YazListenerWidget`` works with any ``ChangeNotifier`` instance. There is no other widget for state management.

````dart
    YazListenerWidget(
      changeNotifier: changeNotifier,
      builder: (BuildContext c) {
        return MyWidget();  
      }     
    );
````

Also you can create ``YazListenerWidget`` instance by ``.builder`` method works on any ``ChangeNotifier``s.

````dart
  changeNotifier.builder((context) => MyWidget());
````

### _! Performance Tip:_

Narrow down this widget as narrow as possible. Using more ``YazListenerWidget``s is better than using a single widget to wrap all things.


### Single Variable

````dart
  /// define notifier
  var counter = 0.notifier;

  /// Listen with widget
  YazListenerWidget(
    changeNotifier: counter,
    builder: (BuildContext c) {
    return Text(counter.value.toString());
  }
  
  //or

  counter.builder((context) => Text(counter.value.toString()))
);
````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/single_changes.gif)

### Multiple Variable

````dart
  /// define notifiers
  final counter1 = 0.notifier;
  final counter2 = 5.notifier;
  final counter3 = 10.notifier;

  /// Listen with widget
  YazListenerWidget(
    changeNotifier: counter1.combineWith([counter2, counter3]),
    /// or changeNotifier:  MultipleChangeNotifier([counter1 , counter2 ,counter3]),
    /// or changeNotifier: [counter1 , counter2, counter3].notifyAll
    builder: (BuildContext c) {
    return Text(counter.value.toString());
  }
);
````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/multiple_changes.gif)


## How to listen collection changes?

There are 3 ways to listen collections

### 1) Classical Total Changes - Bad Way

In this way, standard ``.notifier`` is used

But this triggers only like this;

````dart
    var list = [0,1,2,3].notifier
    
    list.value = [10 , 20 , 30]; // Triggered
    
    list.value[0] = 50; // Not Triggered

    // USAGE
    YazListenerWidget(
        changeNotifier: list,
        //....
    );
````

### 2) Triggering in any changes - Mid-Way

In this way, a YazList is created.

A ``YazList`` can be created by ``.listenAll`` from all ``List`` instances.

``YazMap`` can be created from all ``Map``s by this way, as well.

``YazList`` is a ``ChangeNotifier`` and all listeners are triggered in any changes.

````dart
    YazList<int> list = [0,1,2,3].listenAll;
    list[0] = 5; // Triggered
    list.add(10) = 10; // Triggered
    list.remove(0) = 30; // Triggered
    /// triggered by all methods similarly
    // USAGE
    YazListenerWidget(
      changeNotifier: list,
      //....
    );
````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/list_2.gif)

### 3) Trigger every element separately - Good Way

You can get a ``List<YazNotifier>`` on any ``List`` by ``.listeners`` method.

In this way, ``value`` changes of elements trigger all listeners


When making length-changings like adding or removing elements or making ``YazNotifier`` instance changes; listeners are NOT triggered.


For instance, let us assume that there are two separate widgets to listen index of 0 and index of 1.
When index of 0 is changed, only the widget of 0 is rebuilt.
Other one is not rebuilt.

To trigger all changes, ``.notifyAll`` method on ``List<YazNotifier>`` may be used.

````dart
var listeners = [0,1].listeners;

// 0. Widget
YazListenerWidget(
changeNotifier: listeners[0],
//....
);

// 1. Widget
YazListenerWidget(
changeNotifier: listeners[1],
//....
);

// 2. Widget
YazListenerWidget(
changeNotifier: listeners.notifyAll,
//....
);

listeners[0].value++; // Rebuilt 0. and 2. Widgets
listeners[1].value++; // Rebuilt 1. and 2. Widgets
````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/list_3.gif)

All can be applied on ``Map``.
You can get a ``Map<K, YazNotifier<V>>`` by ``.listeners`` on ``Map``.




## How to listen Stream?

All streams convertible by ``.yazStream`` or ``.yazStreamWithDefault(value)`` on Stream 

``.yazStream`` returns nullable ``YazStream<T?>``

``.yazStreamWithDefault(value)`` returns non-nullable ``YazStream<T>``

````dart
YazStream<User?> stream = db.getChanges().yazStream;
stream.builder((context) => YourWidget());

/// DON'T FORGET
stream.cancel();
````


## User Options

You can manage every user option by this service.

You can get option in everywhere:
  ````dart
    UserOption<double>("font_size").value;
  ````
and you change
````dart
    UserOption<double>("font_size").value = 10.0;
````


You can wrap your widgets with options, when options are changed the widgets are rebuilt;
````dart
  OptionsWrapper(
    option: UserOption<double>("font_size"),
    builder : (c , option) {
      return Text("Hello World!" , style:TextStyle(
        fontSize: option.value
      ));  
    }   
  )
````

You can init by your default values;
````dart
  UserOptions().init(List<UserOption> list);
````

You can listen changes for to fetch on db
````dart
UserOptions().onUserOptionsChange((options){
  //fetch
});
````

If you don't use init functions, you may set default values in the first use.
You don't have to set default values for your further uses in session flow.
````dart
UserOption<double>("font_size" , defaultValue: 10);
````


## Content Controller

You can store or cache your common uses contents.

For example: Friend users, e-commerce categories eg.

Just! you will get content with their identifier.

You don't need a second query from db to recall content repeatedly.

However, if the content is too old, it will be restored from db.
````dart
  var controller = UserController();
  await controller.getContent("user_1");
  /// If content was brought before will get from local
  /// else will get from db, save to local and return to you
````

### Usage
  
#### Implement ``CacheAble``

Your cache able class must have a unique identifier.

````dart

///
class User with CacheAble<User> {
  ///
  User(this.userId, this.userName);
  
  @override
  String get identifier => userId;

  ///
  String userId;

  ///
  String userName;
}

````

#### Implement your controller

There are two kind content controller:

1) CacheContentController : Store contents only session
2) StorageContentController : Store contents in device key-value storage

`````dart
///
class UserController extends StorageContentController<User> {
  
  /// Singleton recommended

  /// Getter for your content by identifier
  /// common use this getter get content from db
  @override
  Future<User?> contentGetter(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return User(identifier, "User Of $identifier");
  }

  /// DON'T NEED for CacheContentController
  /// NEED for store device storage
  @override
  User fromJson(Map<String, dynamic> map) {
    return User.fromJson(map);
  }

  /// Maximum storage count
  @override
  int get maxCount => 30;

  
  /// Maximum storage duration
  /// If your content older than, recall getter from db
  @override
  Duration get maxDuration => const Duration(minutes: 30);

  /// Save key for local storage
  /// 
  /// DON'T NEED for CacheContentController
  /// NEED for store device storage
  @override
  String get saveKey => "users";

  /// DON'T NEED for CacheContentController
  /// NEED for store device storage
  @override
  Map<String, dynamic> toJson(User instance) {
    return instance.toJson();
  }
}
`````

Also you can inititialize with your unordered contents
````dart
controller.init(contents);
````

Save , update or remove content
But many cases you dont need this. Because if you determine max's carefully,
``getContent`` do these for you.

````dart
controller.save(content);
controller.remove(id);
controller.update(id);
````


## Future

* VersionedContentController : For versioned contents eg: translations documents
* Stream to YazNotifier : eg: Database listener to YazNotifier


### Support Me: mehmedyaz@gmail.com




