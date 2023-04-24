import 'dart:async';
import 'dart:typed_data';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum HomeCard { none, device, customData, generatedData }

class HomeBaseController extends GetxController {
  late final SharedPreferences box;

  final deviceCardKey = GlobalKey<ExpansionTileCardState>();

  final connectionFormKey = GlobalKey<FormBuilderState>();
  final customDataFormKey = GlobalKey<FormBuilderState>();
  final generatedDataFormKey = GlobalKey<FormBuilderState>();
  final responseDetailsFormKey = GlobalKey<FormBuilderState>();
  final recievedDataFormKey = GlobalKey<FormBuilderState>();
  final receivedScrollController = ScrollController();

  SerialPort? _port;
  SerialPortReader? reader;
  // ignore: cancel_subscriptions
  StreamSubscription<Uint8List>? subscription;

  late final ScrollController scrollController;
  late final Future<bool> isDataLoaded;
  late final String pattern;
  late final int timesToSend;

  // HomeCard _selectedCard = HomeCard.device;

  List<SerialPort> _activePorts = [];

  bool _isConnectionSaving = false;

  bool _isCustomDataSending = false;
  bool _isGeneratedDataSending = false;

  String _customData = '';
  String _customResponse = '';
  String _customError = '';

  String _generatedData = '';
  String _generatedResponse = '';
  String _generatedError = '';

  String _receivedResponse = '';
  String _receivedError = '';

  //******************** GETTERS AND SETTERS *********************/
  // HomeCard get selectedCard => _selectedCard;
  // set selectedCard(HomeCard v) => {_selectedCard = v, update()};
  SerialPort? get port => _port;
  set port(SerialPort? v) => {_port = v, update()};
  List<SerialPort> get activePorts => _activePorts;
  set activePorts(List<SerialPort> v) => {_activePorts = v, update()};
  bool get isConnectionSaving => _isConnectionSaving;
  set isConnectionSaving(bool v) => {_isConnectionSaving = v, update()};
  bool get isCustomDataSending => _isCustomDataSending;
  set isCustomDataSending(bool v) => {_isCustomDataSending = v, update()};
  bool get isGeneratedDataSending => _isGeneratedDataSending;
  set isGeneratedDataSending(bool v) => {_isGeneratedDataSending = v, update()};
  String get customData => _customData;
  set customData(String v) => {_customData = v, update()};
  String get customResponse => _customResponse;
  set customResponse(String v) => {_customResponse = v, update()};
  String get customError => _customError;
  set customError(String v) => {_customError = v, update()};
  String get generatedError => _generatedError;
  set generatedError(String v) => {_generatedError = v, update()};
  String get generatedResponse => _generatedResponse;
  set generatedResponse(String v) => {_generatedResponse = v, update()};
  String get generatedData => _generatedData;
  set generatedData(String v) => {_generatedData = v, update()};
  String get receivedResponse => _receivedResponse;
  set receivedResponse(String v) => {_receivedResponse = v, update()};
  String get receivedError => _receivedError;
  set receivedError(String v) => {_receivedError = v, update()};
}
