package org.whu.sqlcipher;

import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class QueryFloatToStringTest extends BaseTest {
    @Test
    public void queryFloatToString() {
        String value = org.whu.sqlcipher.QueryHelper.singleValueFromQuery(database, "SELECT 42.09;");
        assertEquals("42.09", value);
    }
}
