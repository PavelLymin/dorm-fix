package com.example.dormfix

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("152caab1-17a7-4ec4-a0b9-aaa267e6b0a8") // Your generated API key
  }
}