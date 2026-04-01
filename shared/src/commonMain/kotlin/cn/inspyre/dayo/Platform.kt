package cn.inspyre.dayo

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform