import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("YOUR_LOCALE")
    MapKitFactory.setApiKey("152caab1-17a7-4ec4-a0b9-aaa267e6b0a8")
  }
}