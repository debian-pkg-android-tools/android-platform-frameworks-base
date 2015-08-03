include ../../debian/android_includes.mk

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
CPPFLAGS += $(ANDROID_INCLUDES) -I../../include
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.5

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cpp
	cc $< -o $@ $(CXXFLAGS) $(CPPFLAGS)