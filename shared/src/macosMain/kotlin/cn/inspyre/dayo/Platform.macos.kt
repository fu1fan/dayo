package cn.inspyre.dayo

import platform.Foundation.NSProcessInfo

class MacOSPlatform : Platform {
    override val name: String = NSProcessInfo.processInfo.operatingSystemVersionString
}

actual fun getPlatform(): Platform = MacOSPlatform()
