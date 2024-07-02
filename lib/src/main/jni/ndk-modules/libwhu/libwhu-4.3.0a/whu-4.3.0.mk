include $(CLEAR_VARS)
# ./configure  --enable-lwgeom=no --enable-gcp --enable-examples=no --build=x86_64-pc-linux-gnu --host=arm-linux-eabi
# ./configure  --build=x86_64-pc-linux-gnu --host=arm-linux-eabi --without-grib --prefix=$PROJECT/external/gdal
# 20150607.libwhu-4.3.0-dev
LOCAL_MODULE    := whu

# SQLite flags copied from ASOP
common_sqlite_flags := \
 -DHAVE_USLEEP=1 \
 -DSQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=1048576 \
 -DSQLITE_THREADSAFE=1 \
 -DNDEBUG=1 \
 -DSQLITE_ENABLE_MEMORY_MANAGEMENT=1 \
 -DSQLITE_DEFAULT_AUTOVACUUM=1 \
 -DSQLITE_TEMP_STORE=3 \
 -DSQLITE_ENABLE_FTS3 \
 -DSQLITE_ENABLE_FTS3_BACKWARDS \
 -DSQLITE_ENABLE_RTREE=1 \
 -DSQLITE_DEFAULT_FILE_FORMAT=4


# whu flags
# comment out TARGET_CPU in config.h - will be replaced with TARGET_ARCH_ABI
whu_flags := \
 -DOMIT_FREEXL \
 -DTARGET_CPU=\"$(TARGET_ARCH_ABI)\" \
 -Dfdatasync=fsync \
 -DSQLITE_ENABLE_RTREE=1 \
 -DENABLE_GCP=1 \
 -DENABLE_GEOPACKAGE=1 \
 -DENABLE_LIBXML2=1 \
 -DSQLITE_OMIT_BUILTIN_TEST=1 

LOCAL_CFLAGS    := \
 $(common_sqlite_flags) \
 $(whu_flags)

# LOCAL_LDLIBS is always ignored for static libraries
# LOCAL_LDLIBS    := -llog -lz
# LOADABLE_EXTENSION must NOT be defined
# For Whu with VirtualShapes,VirtualXL support iconv is needed
# 2014-07-26 - adapted based on ls -1 result in all directories
# Note: not included are: /src/gaiageo/
# --> Ewkt.c:2071:24: error: expected ')' before 'yymsp'
# - Ewkt.c,geoJSON.c,Gml.c,Kml.c,vanuatuWkt.c
# - lex.Ewkt.c,lex.geoJSON.c,lex.Gml.c,lex.Kml.c,lex.VanuatuWkt.c
# 20150607 - ENABLE_GCP=1: 'GPL v2.0 or any subsequent version'
# 'srsinit/epsg_update' is not included, since it is not needed in the library [tools to create the epsg_inlined_*.c files]
LOCAL_C_INCLUDES := \
 $(SQLITE_PATH) \
 $(WHU_PATH) \
 $(WHU_PATH)/src/headers \
 $(ICONV_PATH)/include \
 $(ICONV_PATH)/libcharset/include \
 $(GEOS_PATH)/include \
 $(GEOS_PATH)/capi \
 $(PROJ4_PATH)/src \
 $(LZMA_PATH)/src/liblzma/api \
 $(XML2_PATH)/include
LOCAL_SRC_FILES := \
 $(WHU_PATH)/src/connection_cache/alloc_cache.c \
 $(WHU_PATH)/src/connection_cache/generator/code_generator.c \
 $(WHU_PATH)/src/control_points/gaia_control_points.c \
 $(WHU_PATH)/src/control_points/grass_crs3d.c \
 $(WHU_PATH)/src/control_points/grass_georef.c \
 $(WHU_PATH)/src/control_points/grass_georef_tps.c \
 $(WHU_PATH)/src/dxf/dxf_load_distinct.c \
 $(WHU_PATH)/src/dxf/dxf_loader.c \
 $(WHU_PATH)/src/dxf/dxf_load_mixed.c \
 $(WHU_PATH)/src/dxf/dxf_parser.c \
 $(WHU_PATH)/src/dxf/dxf_writer.c \
 $(WHU_PATH)/src/gaiaaux/gg_sqlaux.c \
 $(WHU_PATH)/src/gaiaaux/gg_utf8.c \
 $(WHU_PATH)/src/gaiaexif/gaia_exif.c \
 $(WHU_PATH)/src/gaiageo/gg_advanced.c \
 $(WHU_PATH)/src/gaiageo/gg_endian.c \
 $(WHU_PATH)/src/gaiageo/gg_ewkt.c \
 $(WHU_PATH)/src/gaiageo/gg_extras.c \
 $(WHU_PATH)/src/gaiageo/gg_geodesic.c \
 $(WHU_PATH)/src/gaiageo/gg_geoJSON.c \
 $(WHU_PATH)/src/gaiageo/gg_geometries.c \
 $(WHU_PATH)/src/gaiageo/gg_geoscvt.c \
 $(WHU_PATH)/src/gaiageo/gg_gml.c \
 $(WHU_PATH)/src/gaiageo/gg_kml.c \
 $(WHU_PATH)/src/gaiageo/gg_lwgeom.c \
 $(WHU_PATH)/src/gaiageo/gg_matrix.c \
 $(WHU_PATH)/src/gaiageo/gg_relations.c \
 $(WHU_PATH)/src/gaiageo/gg_relations_ext.c \
 $(WHU_PATH)/src/gaiageo/gg_shape.c \
 $(WHU_PATH)/src/gaiageo/gg_transform.c \
 $(WHU_PATH)/src/gaiageo/gg_vanuatu.c \
 $(WHU_PATH)/src/gaiageo/gg_voronoj.c \
 $(WHU_PATH)/src/gaiageo/gg_wkb.c \
 $(WHU_PATH)/src/gaiageo/gg_wkt.c \
 $(WHU_PATH)/src/gaiageo/gg_xml.c \
 $(WHU_PATH)/src/geopackage/gaia_cvt_gpkg.c \
 $(WHU_PATH)/src/geopackage/gpkgAddGeometryColumn.c \
 $(WHU_PATH)/src/geopackage/gpkg_add_geometry_triggers.c \
 $(WHU_PATH)/src/geopackage/gpkg_add_spatial_index.c \
 $(WHU_PATH)/src/geopackage/gpkg_add_tile_triggers.c \
 $(WHU_PATH)/src/geopackage/gpkgBinary.c \
 $(WHU_PATH)/src/geopackage/gpkgCreateBaseTables.c \
 $(WHU_PATH)/src/geopackage/gpkgCreateTilesTable.c \
 $(WHU_PATH)/src/geopackage/gpkgCreateTilesZoomLevel.c \
 $(WHU_PATH)/src/geopackage/gpkgGetImageType.c \
 $(WHU_PATH)/src/geopackage/gpkg_get_normal_row.c \
 $(WHU_PATH)/src/geopackage/gpkg_get_normal_zoom.c \
 $(WHU_PATH)/src/geopackage/gpkgInsertEpsgSRID.c \
 $(WHU_PATH)/src/geopackage/gpkgMakePoint.c \
 $(WHU_PATH)/src/md5/gaia_md5.c \
 $(WHU_PATH)/src/md5/md5.c \
 $(WHU_PATH)/src/shapefiles/shapefiles.c \
 $(WHU_PATH)/src/shapefiles/validator.c \
 $(WHU_PATH)/src/whu/extra_tables.c \
 $(WHU_PATH)/src/whu/mbrcache.c \
 $(WHU_PATH)/src/whu/metatables.c \
 $(WHU_PATH)/src/whu/se_helpers.c \
 $(WHU_PATH)/src/whu/whu.c \
 $(WHU_PATH)/src/whu/whu_init.c \
 $(WHU_PATH)/src/whu/srid_aux.c \
 $(WHU_PATH)/src/whu/statistics.c \
 $(WHU_PATH)/src/whu/table_cloner.c \
 $(WHU_PATH)/src/whu/virtualbbox.c \
 $(WHU_PATH)/src/whu/virtualdbf.c \
 $(WHU_PATH)/src/whu/virtualelementary.c \
 $(WHU_PATH)/src/whu/virtualfdo.c \
 $(WHU_PATH)/src/whu/virtualgpkg.c \
 $(WHU_PATH)/src/whu/virtualnetwork.c \
 $(WHU_PATH)/src/whu/virtualshape.c \
 $(WHU_PATH)/src/whu/virtualspatialindex.c \
 $(WHU_PATH)/src/whu/virtualXL.c \
 $(WHU_PATH)/src/whu/virtualxpath.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_00.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_01.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_02.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_03.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_04.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_05.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_06.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_07.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_08.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_09.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_10.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_11.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_12.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_13.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_14.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_15.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_16.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_17.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_18.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_19.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_20.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_21.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_22.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_23.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_24.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_25.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_26.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_27.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_28.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_29.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_30.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_31.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_32.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_33.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_34.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_35.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_36.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_37.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_38.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_39.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_40.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_41.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_42.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_43.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_44.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_45.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_46.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_extra.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_prussian.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_wgs84_00.c \
 $(WHU_PATH)/src/srsinit/epsg_inlined_wgs84_01.c \
 $(WHU_PATH)/src/srsinit/srs_init.c \
 $(WHU_PATH)/src/versioninfo/version.c \
 $(WHU_PATH)/src/virtualtext/virtualtext.c \
 $(WHU_PATH)/src/wfs/wfs_in.c
LOCAL_STATIC_LIBRARIES := iconv proj geos libxml2
include $(BUILD_STATIC_LIBRARY)
