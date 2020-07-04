package cn.geek51.util;

import java.util.UUID;

/**
 * @Auther: leo
 * @Date: 2020/04/11 10:04
 * @Description: uuid生成工具
 */
public class UuidUtil {
    public static String getUuid() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}
