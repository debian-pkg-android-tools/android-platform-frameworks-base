NAME = split-select
SOURCES = Abi.cpp \
          Grouper.cpp \
          Rule.cpp \
          RuleGenerator.cpp \
          SplitDescription.cpp \
          SplitSelector.cpp \
          Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/split-select/$(source))
CXXFLAGS += -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h -I/usr/include/android \
            -Itools -Iinclude -D_DARWIN_UNLIMITED_STREAMS
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android:/usr/lib/android \
           -L/usr/lib/android -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -llog -lutils \
           -L. -landroidfw -laapt

build: $(SOURCES)
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)