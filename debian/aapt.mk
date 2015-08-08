include /usr/include/android/arch/android_includes.mk

SOURCES = AaptAssets.cpp \
          AaptConfig.cpp \
          AaptUtil.cpp \
          AaptXml.cpp \
          ApkBuilder.cpp \
          Command.cpp \
          CrunchCache.cpp \
          FileFinder.cpp \
          Images.cpp \
          Package.cpp \
          pseudolocalize.cpp \
          qsort_r_compat.c \
          Resource.cpp \
          ResourceFilter.cpp \
          ResourceIdCache.cpp \
          ResourceTable.cpp \
          SourcePos.cpp \
          StringPool.cpp \
          WorkQueue.cpp \
          XMLNode.cpp \
          ZipEntry.cpp \
          ZipFile.cpp
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android

build: aapt

clean:
	rm -f aapt *.so*

aapt: Main.cpp libaapt.so
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) \
	    -lrt -ldl -lpthread -L. -laapt -L/usr/lib/android -lutils \
	    -L../../libs/androidfw -landroidfw

libaapt.so: $(SOURCES)
	c++ $^ -o libaapt.so.${UPSTREAM_LIBVERSION} $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) \
	    -shared -Wl,-soname,libaapt.so.5 \
	    -lpng -lz -lexpat \
	    -L/usr/lib/android -llog -lcutils -lutils -lziparchive \
	    -L../../libs/androidfw -landroidfw \
	    -DSTATIC_ANDROIDFW_FOR_TOOLS
	ln -s libaapt.so.${UPSTREAM_LIBVERSION} libaapt.so
	ln -s libaapt.so.${UPSTREAM_LIBVERSION} libaapt.so.5