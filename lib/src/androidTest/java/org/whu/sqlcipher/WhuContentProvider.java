package org.whu.sqlcipher;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.database.Cursor;
import android.net.Uri;

import org.whu.database.SQLiteDatabase;
import org.whu.database.SQLiteQueryBuilder;

import java.io.File;

public class WhuContentProvider extends ContentProvider {

    public static final Uri CONTENT_URI =
            Uri.parse("content://org.whu.testsuite.provider");

    public static String DATABASE_NAME = "test.db";

    private SQLiteDatabase database;

    public WhuContentProvider() {
    }

    @Override
    public boolean onCreate() {
        return true;
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {

        File databasePath = getContext().getDatabasePath(DATABASE_NAME);
        database = SQLiteDatabase.openOrCreateDatabase(databasePath, null);

        createDatabaseWithData(database);
        SQLiteQueryBuilder builder = new SQLiteQueryBuilder();
        builder.setTables("t1");
        return builder.query(database, new String[]{"a", "b"}, null, null, null, null, null);
    }

    @Override
    public String getType(Uri uri) {
        return null;
    }

    @Override
    public Uri insert(Uri uri, ContentValues contentValues) {
        return null;
    }

    @Override
    public int delete(Uri uri, String s, String[] strings) {
        return 0;
    }

    @Override
    public int update(Uri uri, ContentValues contentValues, String s, String[] strings) {
        return 0;
    }

    private void createDatabaseWithData(SQLiteDatabase database) {
        database.execSQL("create table if not exists t1(a, b);");
        database.execSQL("insert into t1(a, b) values('one for the money', 'two for the show');");
    }
}
