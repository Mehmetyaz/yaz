import 'package:flutter/cupertino.dart';

import '../listenable/multiple_change_notifier.dart';

///
typedef OnOptionChange = void Function(UserOption option);

///
typedef OnOptionsChange = void Function(Map<String, UserOption> options);

/// Singleton class for store your options
///
/// You can use this class for;
///
/// * listen all changes with [onOptionsChange]
/// * listen single options changes [onOptionChange]
/// * get all options [userOptions]
/// * update options [update]
/// * set all options in initialize [init]
class UserOptions {
  /// This default constructor give you same instance
  factory UserOptions() => _instance;

  UserOptions._();

  static final UserOptions _instance = UserOptions._();

  /// All user options that be initialized
  final Map<String, UserOption> userOptions = {};

  /// Init options blank.
  ///
  /// If you have store user options (db etc.)
  /// you can init once for session
  ///
  /// If you initialize secondary times (or more)
  /// options override,
  /// WARN !! init function not trigger your wrappers
  void init(List<UserOption> initialOptions) {
    for (var o in initialOptions) {
      userOptions[o.name] = o;
    }
  }

  /// You can use for change option instance
  /// WARN !! This function not trigger wrappers
  /// So only use for options initialize
  ///
  /// Alternatively use anywhere:
  /// ```dart
  ///   UserOption<int>("my_option" , defaultValue : 10)
  /// ```
  /// In this example if options sett before in this session
  /// you will get existing value,
  /// if not, you will get 10
  ///
  void setOption(UserOption option) {
    userOptions[option.name] = option;
  }

  /// You can use for change option value
  /// This function trigger your wrappers
  ///
  /// Alternatively use anywhere:
  /// ```dart
  ///   UserOption<int>("my_option").value = 20
  /// ```
  ///
  void update(UserOption option) {
    userOptions[option.name]!.value = option.value;
  }

  /// If option is exists you can get option
  ///
  /// Alternatively(and recommended) use everywhere :
  /// ```dart
  ///   UserOption("option_name");
  /// ```
  ///
  /// If not initialize this option before
  /// you will get Exception.
  ///
  UserOption? getOption(String name) => userOptions[name];

  /// !!! Not recommend
  // ignore: comment_references
  /// For flutter widgets, use [OptionsWrapper]
  ///
  /// this functions usage goal is database commit
  ///
  void onOptionChange(String optionName, OnOptionChange onOptionChange) {
    void _listener() {
      onOptionChange(userOptions[optionName]!);
    }

    userOptions[optionName]!.addListener(_listener);
  }

  /// !!! Not recommend
  // ignore: comment_references
  /// For flutter widgets, use [OptionsWrapper]
  ///
  /// this functions usage goal is database commit
  ///
  void onOptionsChange(
      List<String> optionNames, OnOptionsChange onOptionsChange) {
    void _listener() {
      onOptionsChange(userOptions.values
          .where((element) => optionNames.contains(element.name))
          .toList()
          .asMap()
          .map<String, UserOption>(
              (key, value) => MapEntry(value.name, value)));
    }

    MultipleChangeNotifier(userOptions.values
            .where((element) => optionNames.contains(element.name))
            .toList())
        .addListener(_listener);
  }
}

/// Single User Option.
/// You can get everywhere.
///
/// If you have construct [UserOption],
/// you will get option with existing value
///
/// If options does not exists you must define default value.
/// In this case options will save
class UserOption<T> extends ChangeNotifier {
  /// if you not type default value, you must ensure initialized user options
  ///
  /// creating the option with the same name once, means save option
  factory UserOption(String name, {T? defaultValue}) {
    return (UserOptions().getOption(name) ??
            UserOption<T>.create(value: defaultValue as T, name: name))
        as UserOption<T>;
  }

  /// This constructor for initialize Option
  ///
  /// !! Not recommend
  ///
  /// Because this constructor not trigger any wrappers
  ///
  /// If option exists,will override
  UserOption.create({required T value, required this.name}) : _value = value {
    UserOptions().setOption(this);
  }

  /// Please use unique option names
  String name;

  T? _value;

  /// Option Value.
  /// If you use as a setter, trigger your wrappers
  T? get value => _value;

  /// Option Value.
  /// If you use as a setter, trigger your wrappers
  set value(T? value) {
    if (value == _value) return;
    _value = value;
    notifyListeners();
  }
}
