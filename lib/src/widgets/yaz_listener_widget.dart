library yaz_state;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../yaz.dart';

/// Listen changes and rebuilt if necessary
class YazListenerWidget<T extends ChangeNotifier> extends StatefulWidget {
  /// Listen changes and rebuilt if necessary
  const YazListenerWidget(
      {Key? key,
      required this.changeNotifier,
      required this.builder,
      this.notifyOnDebug = true,
      this.onDispose})
      : super(key: key);

  ///
  final T changeNotifier;

  /// Called on widget dispose
  final void Function()? onDispose;

  ///
  final bool notifyOnDebug;

  ///
  /// Listen changes and rebuilt if necessary
  final WidgetBuilder builder;

  @override
  // ignore: no_logic_in_create_state
  YazListenerState<T> createState() => YazListenerState();
}

///
class YazListenerState<T extends ChangeNotifier>
    extends State<YazListenerWidget> {
  @mustCallSuper
  @override
  void initState() {
    _listen();
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    _remove();
    widget.onDispose?.call();

    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant YazListenerWidget<T> oldWidget) {
    _remove();
    _listen();
    super.didUpdateWidget(oldWidget);
  }

  void _listen() {
    widget.changeNotifier.addListener(_listener);
  }

  void _remove() {
    widget.changeNotifier.removeListener(_listener);
  }

  @override
  void reassemble() {
    super.reassemble();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    var _child = widget.builder(context);
    if (widget.notifyOnDebug &&
        UserOption<bool>("always_notify_built_debug", defaultValue: false)
            .value &&
        kDebugMode) {
      return BuiltNotifier(child: _child);
    }
    return _child;
  }
}
