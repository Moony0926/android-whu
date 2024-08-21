f-keepclasseswithmembers class org.whu.** {
  native <methods>;
  public <init>(...);
}
-keepnames class org.whu.** { *; }
-keep public class org.whu.database.SQLiteCustomFunction { *; }
-keep public class org.whu.database.SQLiteCursor { *; }
-keep public class org.whu.database.SQLiteDebug** { *; }
-keep public class org.whu.database.SQLiteDatabase { *; }
-keep public class org.whu.database.SQLiteOpenHelper { *; }
-keep public class org.whu.database.SQLiteStatement { *; }
-keep public class org.whu.CursorWindow { *; }
-keepattributes Exceptions,InnerClasses
