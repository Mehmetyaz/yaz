# yaz

Yaz State and Content Manager Package

# Introduction

Web, Mobile and Desktop Supported

Yaz consists of two parts ;

#### 1) State Management

[Demo App Video](https://youtu.be/qyjq9laVdgE)

* Yaz, firstly is a state management package based ``ChangeNotifier`` simple and fast. It does this with only
  one ``widget`` of ``YazListenerWidget``.

* Yaz, help to you convert your any object to ``ChangeNotifier`` with simple code.

* Yaz, support collection(``List`` and ``Map``) changes seperately or fully.

#### 2) Content Management

* Yaz, help to you your user options set and get everywhere and everytime.

* Yaz, help to you store and cache your frequently used contents.

# Usage

## Convert Object To Change Notifier

Any object convertible to change notifier ``YazNotifier``

``.notifier`` work on any object and return ``YazNotifier``

````dart
    var counter = 0.notifier;
    var editing = "Mehmet Yaz".notifier; 
    var foo = Foo().notifier; 
````

You can get current value And you set value with ``.value``; This setter trigger changes

````dart
    print(counter.value);
    // out - 0 -
    
    counter.value++;
    
    print(counter.value);
    // out - 1 -
````

### _! Warning:_

if you want to listen changes ``Foo()`` instance members:

````dart
    // DON'T
    var foo = Foo().notifier;
````

````dart
    // DO
    var bar = Foo().bar.notifier;
````

Because ``foo`` only trigger changes like that :

````dart
    foo.value =  Foo(); // new instance
````

### Built Notifier
We can wrap the widget we want with the built-in notifier. It is painted when it is rebuilt.

`````dart
  BuiltNotifier(
        child: YourWidget()
        );
`````
![Example](https://github.com/Mehmetyaz/yaz/blob/master/example/gifs/single_changes.gif)

## YazListenerWidget

``YazListenerWidget`` work with any ``ChangeNotifier`` instance. There is no other widget for state management.

````dart
    YazListenerWidget(
      changeNotifier: changeNotifier,
      builder: (BuildContext c) {
        return MyWidget();  
      }     
    );
````

### _! Performance Tip:_

Use as small pieces as possible. Use more YazListenerWidgets rather than cover more widgets.


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
);
````

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


## Listen collection changes

There are 3 ways collection listen

### 1) Classic Totally Changes - Bad Way

In this case, use standart ``.notifier``

But only triggers like this

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

### 2) Trigger Any Changes - Mid Way

In this case, created ``YazList`` and YazList have all methods of ``List``

Also ``YazMap`` same.

You can create ``YazList`` from any list with ``.listenAll``

YazList is a ChangeNotifier and triggered any changes:

````dart
    YazList<int> list = [0,1,2,3].listenAll;
    list[0] = 5; // Triggered
    list.add(10) = 10; // Triggered
    list.remove(0) = 30; // Triggered
    /// similarly triggered all changes
    // USAGE
    YazListenerWidget(
      changeNotifier: list,
      //....
    );
````

This case rebuilt every ``list`` listeners on every changes.
So if you have one(or some) listeners and you need all list you can use ``YazList`` or ``YazMap``

### 3) Trigger every element saperately - Good Way

You can get ``List<YazNotifier>`` on any ``List`` with ``.listeners``

In this case changes (exclude add , remove and similar length-shifting or instance changing methods) 
triggered if have listeners

So for example there are two separate widgets that only listen index of 0 and 1.
when index of 0 change , other widget not rebuilt;

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

the same things apply ``Map``
You can get ``Map<K, YazNotifier<V>>`` on any ``Map`` with ``.listeners``


## User Options

You can manage every user options with this service

You can get everywhere:
  ````dart
    UserOption<double>("font_size").value;
  ````
and set

````dart
    UserOption<double>("font_size").value = 10.0;
````


You can wrap your widgets with options,
when options changed widget rebuilt;
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

You can init with your default values;
````dart
  UserOptions().init(List<UserOption> list);
````

Listen changes for fetch to db
````dart
UserOptions().onUserOptionsChange((options){
  //fetch
});
````

If you haven't init functions set defaults in first use.
no need for further use
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




