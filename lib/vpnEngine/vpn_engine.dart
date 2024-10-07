import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vpn_basic_project/models/vpn_configuration.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';

class VpnEngine {
  // native channel
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String methodChannelVPnControl = "vpnControl";

  // Display the stage of the VPN
  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  // Display the status of the VPN
  static Stream<VpnStatus> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus)))
          .cast();

  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChannelVPnControl).invokeMethod("start", {
      "config": vpnConfiguration.config,
      "country": vpnConfiguration.countryname,
      "username": vpnConfiguration.username,
      "password": vpnConfiguration.password,
    });
  }

  static Future<void> stopVpnNow() {
    return MethodChannel(methodChannelVPnControl).invokeMethod("stop");
  }

  static Future<void> killSwitchOpenNow() {
    return MethodChannel(methodChannelVPnControl).invokeMethod("kill_switch");
  }

  static Future<void> refreshStageNow() {
    return MethodChannel(methodChannelVPnControl).invokeMethod("refresh");
  }

  static Future<String?> getStageNow() {
    return MethodChannel(methodChannelVPnControl).invokeMethod("stage");
  }

  static Future<bool> isConnectedNow() {
    return getStageNow().then(
      (value) => value!.toLowerCase() == "connected",
    );
  }

  static const String vpnConnectedNow = "connected";
  static const String vpnDisconnectedNow = "disconnected";
  static const String vpnWaitconnectionNow = "wait_connection";
  static const String vpnAuthenticatingNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNoConnectionNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
