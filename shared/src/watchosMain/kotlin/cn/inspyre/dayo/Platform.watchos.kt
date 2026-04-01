package cn.inspyre.dayo

import platform.WatchKit.WKInterfaceDevice

class WatchOSPlatform : Platform {
    override val name: String =
        WKInterfaceDevice.currentDevice().systemName() + " " + WKInterfaceDevice.currentDevice().systemVersion
}

actual fun getPlatform(): Platform = WatchOSPlatform()
