import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IOSTabWidget extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTabChanged;
  final int initialIndex;

  const IOSTabWidget({
    Key? key,
    required this.tabs,
    this.onTabChanged,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _IOSTabWidgetState createState() => _IOSTabWidgetState();
}

class _IOSTabWidgetState extends State<IOSTabWidget> {
  static const MethodChannel _channel = MethodChannel('ios_tab_widget');
  int _currentIndex = 0;
  bool _useNative = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _decideAndInit();
  }

  Future<void> _decideAndInit() async {
    _useNative = await _isIOS26OrNewer();
    if (_useNative) {
      await _initializeNativeTabView();
    }
    if (mounted) setState(() {});
  }

  Future<bool> _isIOS26OrNewer() async {
    if (!Platform.isIOS) return false;
    try {
      final info = await DeviceInfoPlugin().iosInfo;
      final versionString = info.systemVersion; // e.g. "17.4.1"
      final major = int.tryParse(versionString.split('.').first) ?? 0;
      return major >= 26;
    } catch (_) {
      return false;
    }
  }

  Future<void> _initializeNativeTabView() async {
    try {
      await _channel.invokeMethod('initialize', {
        'tabs': widget.tabs,
        'initialIndex': widget.initialIndex,
      });
    } on PlatformException catch (e) {
      print('Error initializing iOS tab view: \$e');
    }
  }

  Future<void> _selectTab(int index) async {
    try {
      if (_useNative) {
        await _channel.invokeMethod('selectTab', {'index': index});
      }
      setState(() {
        _currentIndex = index;
      });
      widget.onTabChanged?.call(index);
    } on PlatformException catch (e) {
      print('Error selecting tab: \$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _selectTab(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                widget.tabs[index],
                style: TextStyle(
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                  fontSize: 16,
                  fontWeight: _currentIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
