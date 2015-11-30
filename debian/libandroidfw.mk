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
CXXFLAGS += -fPIC -std=gnu++11 -DSTATIC_ANDROIDFW_FOR_TOOLS
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -I/usr/include/android
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 -lz \
           -L/usr/lib/android -lziparchive -lutils -lcutils -llog

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*