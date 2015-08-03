include /usr/include/android/arch/android_includes.mk

NAME = aapt
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
          ZipFile.cpp \
          Main.cpp
CXXFLAGS += -fPIC -c -Wno-format-y2k -DSTATIC_ANDROIDFW_FOR_TOOLS
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android \
           -lrt -ldl -lpthread -lpng -lz -lexpat \
           -L../../libs/androidfw -landroidfw \
           -L/usr/lib/android -llog -lutils -lcutils -lziparchive

build: $(SOURCES)
	cc $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LOCAL_LDFLAGS)

clean:
	rm -f $(NAME)