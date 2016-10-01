NAME = aapt
SOURCES = Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt/$(source))
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(ANDROID_BUILD_TOOLS_VERSION)\" \
            -Iinclude
LDFLAGS += -Wl,-rpath=debian/out:/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Wl,-rpath-link=debian/out -Ldebian/out -laapt \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -lutils

build: $(SOURCES)
	mkdir --parents debian/out
	$(CXX) $^ -o debian/out/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) debian/out/$(NAME)
