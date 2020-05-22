package com.niucong.flutterapp

import android.Manifest
import android.R
import android.content.*
import android.content.pm.PackageManager
import android.graphics.Color
import android.os.BatteryManager
import android.os.Build
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup.MarginLayoutParams
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.Nullable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    private val CHANNEL = "samples.flutter.io/battery"
    private val CHARGING_CHANNEL = "samples.flutter.io/charging"
//    val STREAM = "com.flutter.eventchannel/stream"

    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
//        EventChannel(flutterEngine.dartExecutor, STREAM).setStreamHandler(
//                object : StreamHandler {
//                    override fun onListen(args: Any, events: EventSink) {
//                        // 这样我们就可以通过监听，随时随地发送消息指令给Flutter客户端了
//                        Log.i("info", "adding listener")
//                        events.success("从原生发送过来的指令信息")
//                    }
//
//                    override fun onCancel(args: Any) {
//                        Log.i("info", "cancelling listener")
//                    }
//                }
//        )

        EventChannel(flutterEngine.dartExecutor, CHARGING_CHANNEL).setStreamHandler(
                object : StreamHandler {
                    private var chargingStateChangeReceiver: BroadcastReceiver? = null
                    override fun onListen(arguments: Any?, events: EventSink?) {
                        chargingStateChangeReceiver = events?.let { createChargingStateChangeReceiver(it) }
                        registerReceiver(
                                chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                    }

                    override fun onCancel(arguments: Any?) {
                        unregisterReceiver(chargingStateChangeReceiver)
                        chargingStateChangeReceiver = null
                    }
                }
        )

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { methodCall, result ->
            when (methodCall.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                "requestPermission" -> {
                    // 申请权限，获取参数
                    val permissionName: String? = methodCall.argument("permissionName")
                    val permissionId: Int? = methodCall.argument("permissionId")
                    // 调用申请权限方法
                    val hasPermission = requestPermission()
                    println("$permissionName   $permissionId")
                    // 回调返回结果给Flutter
                    result.success(hasPermission)
                }
                "addNativeLayout" -> {
                    // 添加布局到现有的Flutter布局中
                    val v = findViewById<View>(R.id.content) as FrameLayout
                    val linearLayout: View = LinearLayout(this@MainActivity)
                    linearLayout.setBackgroundColor(-0xff4001)
                    val marginLayoutParams = MarginLayoutParams(600, 600)
                    (linearLayout as LinearLayout).gravity = Gravity.CENTER
                    marginLayoutParams.setMargins(200, 230, 0, 0)
                    linearLayout.setLayoutParams(marginLayoutParams)
                    v.addView(linearLayout)
                    val textView = TextView(this@MainActivity)
                    textView.text = "我是原生布局/控件"
                    textView.setTextColor(Color.parseColor("#FFFFFF"))
                    textView.gravity = Gravity.CENTER
                    linearLayout.addView(textView)
//                    addContentView(v)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null)
                } else {
                    val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                            status == BatteryManager.BATTERY_STATUS_FULL
                    events.success(if (isCharging) "charging" else "discharging")
                }
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

    // 请求权限
    private fun requestPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED) {
                requestPermissions(arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                        0)
                false
            } else {
                true
            }
        } else true
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 0) {
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(this, "权限已申请", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "权限已拒绝", Toast.LENGTH_SHORT).show();
            }
        }
    }

}
