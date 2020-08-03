package cn.geek51.util;

import com.alibaba.fastjson.JSONArray;


import java.util.List;

/**
 * @Auther: leo
 * @Date: 2020/04/11 14:36
 * @Description: 字符串处理工具类
 */
public class StringUtils extends org.springframework.util.StringUtils {

    public static boolean isEmpty(Object... parsms) {

        if (null == parsms)
            return true;
        for (Object obj : parsms) {
            if (null == obj) {
                return true;
            }
            if (obj instanceof String) {
                String str = String.valueOf(obj);
                if (StringUtils.isEmpty(str)) {
                    return true;
                }
            }
            if (obj instanceof List) {
                List tmp = (List) obj;
                if (tmp.isEmpty()) {
                    return true;
                }
            }
            if (obj instanceof JSONArray) {
                JSONArray tmp = (JSONArray) obj;
                if (tmp.isEmpty()) {
                    return true;
                }
            }
        }
        return false;
    }

    public static boolean isNotEmpty(Object... parsms) {
        return !isEmpty(parsms);
    }

    public static boolean isNotEmpty(Object parsms) {
        return !isEmpty(parsms);
    }
}
