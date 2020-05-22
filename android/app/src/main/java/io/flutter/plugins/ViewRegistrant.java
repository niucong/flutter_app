//package io.flutter.plugins;
//
//import com.amap.api.maps.MapView;
//import com.niucong.flutterapp.MapViewFactory;
//
//import io.flutter.plugin.common.PluginRegistry;
//import io.flutter.plugin.common.StandardMessageCodec;
//
///**
// * @Author: niucong
// * 时  间: 2020/5/20 16:36
// * 项目名: android
// * 包  名：io.flutter.plugins
// * 类  名：ViewRegistrant
// * 简  述：<功能简述>
// */
//public final class ViewRegistrant {
//
//    public static void registerWith(PluginRegistry registry, MapView mapView) {
//        final String key = ViewRegistrant.class.getCanonicalName();
//        if (registry.hasPlugin(key)) {
//            return;
//        }
//        PluginRegistry.Registrar registrar = registry.registrarFor(key);
//        registrar.platformViewRegistry().registerViewFactory("AMapView", new MapViewFactory(new StandardMessageCodec(), mapView));
//    }
//}
