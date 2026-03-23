import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("1c457cdb-845b-46df-aa96-8682605cacba") // Your generated API key
  }
}