package com.niucong.flutterapp;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CustomViewFactory extends PlatformViewFactory {
    public CustomViewFactory(MessageCodec<Object> messageCodec) {
        super(messageCodec);
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> param = (Map<String, Object>) o;
        String text = (String) param.get("text");
        return new CustomView(context, text);
    }
}
