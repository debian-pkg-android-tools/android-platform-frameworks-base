NAME = aapt
SOURCES = Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(BUILD_TOOLS_VERSION)\" \
            -include android/arch/AndroidConfig.h \
            -I/usr/include/android -Iinclude
LDFLAGS += -Wl,-rpath=/usr/lib/android -Wl,-rpath-link=. \
           -L/usr/lib/android -lutils -L. -laapt

build: $(SOURCES)
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)