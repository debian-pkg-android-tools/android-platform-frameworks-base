NAME = aapt
SOURCES = Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(BUILD_TOOLS_VERSION)\" \
            -include android/arch/AndroidConfig.h \
            -I/usr/include/android -Iinclude
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android:/usr/lib/android \
           -L/usr/lib/android -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -lutils \
           -Wl,-rpath-link=. -L. -laapt

build: $(SOURCES)
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)