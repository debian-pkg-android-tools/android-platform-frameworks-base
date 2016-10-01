NAME = libandroidfw
SOURCES = Asset.cpp \
          AssetDir.cpp \
          AssetManager.cpp \
          LocaleData.cpp \
          misc.cpp \
          ObbFile.cpp \
          ResourceTypes.cpp \
          StreamingZipInflater.cpp \
          TypeWrappers.cpp \
          ZipFileRO.cpp \
          ZipUtils.cpp
SOURCES := $(foreach source, $(SOURCES), libs/androidfw/$(source))
CXXFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS
CPPFLAGS += -Iinclude
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lz \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lziparchive -lutils -lcutils -llog

build: $(SOURCES)
	mkdir --parents debian/out
	$(CXX) $^ -o debian/out/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so

clean:
	$(RM) debian/out/$(NAME).so*