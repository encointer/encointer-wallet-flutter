package org.encointer.wallet

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.jakewharton.threetenabp.AndroidThreeTen

class MainActivity: FlutterActivity() {
  // You do not need to override onCreate() in order to invoke
  // GeneratedPluginRegistrant. Flutter now does that on your behalf.

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        AndroidThreeTen.init(this);
    }
}


