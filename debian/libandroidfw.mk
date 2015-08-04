include /usr/include/android/arch/android_includes.mk

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
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -DSTATIC_ANDROIDFW_FOR_TOOLS
CPPFLAGS += $(ANDROID_INCLUDES) -I../../include -I/usr/include/android
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.5 -lz \
           -L/usr/lib/android -lziparchive -lutils -lcutils -llog

build: $(OBJECTS)
	c++ $^ -o $(NAME).so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)