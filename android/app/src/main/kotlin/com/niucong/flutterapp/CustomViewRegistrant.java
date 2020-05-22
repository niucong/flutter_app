package com.niucong.flutterapp;

import android.util.Log;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;

public class CustomViewRegistrant {

    private static final String TAG = CustomViewRegistrant.class.getName();

    public static void registerWith(PluginRegistry registry) {
        final String key = CustomViewRegistrant.class.getCanonicalName();
        Log.i(TAG, "registerKey=" + key);
        if (registry.hasPlugin(key)) {
            return;
        }

        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("widget.name", new CustomViewFactory(new StandardMessageCodec()));
    }

}
