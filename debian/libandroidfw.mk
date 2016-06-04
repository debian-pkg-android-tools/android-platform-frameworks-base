NAME = libandroidfw
SOURCES = Asset.cpp \
          AssetDir.cpp \
          AssetManager.cpp \
          misc.cpp \
          ObbFile.cpp \
          ResourceTypes.cpp \
          StreamingZipInflater.cpp \
          TypeWrappers.cpp \
          ZipFileRO.cpp \
          ZipUtils.cpp
SOURCES := $(foreach source, $(SOURCES), libs/androidfw/$(source))
CXXFLAGS += -std=gnu++11 -DSTATIC_ANDROIDFW_FOR_TOOLS
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -I/usr/include/android
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android:/usr/lib/android \
           -lz \
           -L/usr/lib/android -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lziparchive -lutils -lcutils -llog

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*