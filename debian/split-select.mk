NAME = split-select
SOURCES = Abi.cpp \
          Grouper.cpp \
          Rule.cpp \
          RuleGenerator.cpp \
          SplitDescription.cpp \
          SplitSelector.cpp \
          Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/split-select/$(source))
CPPFLAGS += -Itools -Iinclude -D_DARWIN_UNLIMITED_STREAMS
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -llog -lutils -Ldebian/out -landroidfw -laapt

build: $(SOURCES)
	mkdir --parents debian/out
	$(CXX) $^ -o debian/out/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) debian/out/$(NAME)