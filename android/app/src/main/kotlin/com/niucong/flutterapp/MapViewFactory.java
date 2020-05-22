package com.niucong.flutterapp;

import android.content.Context;
import android.view.View;

import com.amap.api.maps.MapView;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @Author: niucong
 * 时  间: 2020/5/20 14:27
 * 项目名: android
 * 包  名：com.niucong.flutterapp
 * 类  名：MapViewFactory
 * 简  述：<功能简述>
 */
public class MapViewFactory extends PlatformViewFactory {

    private MapView mapView;

    public MapViewFactory(MessageCodec<Object> createArgsCodec, MapView mapView) {
        super(createArgsCodec);
        this.mapView = mapView;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        return new PlatformView() {
            @Override
            public View getView() {
                return mapView;
            }

            @Override
            public void dispose() {

            }
        };
    }
}
