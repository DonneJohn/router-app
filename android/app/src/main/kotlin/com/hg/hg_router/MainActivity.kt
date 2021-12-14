package com.hg.hg_router

import android.content.Context
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.net.wifi.WifiManager
import android.text.format.Formatter
import android.util.Log


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.hg.hg_router/gatewayIp"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            // Note: this method is invoked on the main thread.
            if (methodCall.method == "getGatewayIp") {
                val ip = getGatewayIp()

                if (ip != null) {
                    result.success(ip)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getGatewayIp(): String {
        val manager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val dhcp = manager.dhcpInfo
        val address = Formatter.formatIpAddress(dhcp.gateway)
        Log.d("MainActivity", "onCreate: $address")
        return address
    }
}
