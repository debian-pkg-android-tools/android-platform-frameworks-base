include /usr/include/android/arch/android_includes.mk

SOURCES = Abi.cpp \
          Grouper.cpp \
          Rule.cpp \
          RuleGenerator.cpp \
          SplitDescription.cpp \
          SplitSelector.cpp
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I.. -I../../include
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android

build: split-select

clean:
	rm -f split-select *.so*

split-select: Main.cpp libsplit-select.so
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) \
	    -lrt -ldl -lpthread -lz -lpng -lexpat \
	    -L. -lsplit-select -L../aapt -laapt -L../../libs/androidfw -landroidfw \
	    -L/usr/lib/android -llog -lutils -lcutils -lziparchive

libsplit-select.so: $(SOURCES)
	c++ $^ -o libsplit-select.so.${UPSTREAM_LIBVERSION} \
	    $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) -D_DARWIN_UNLIMITED_STREAMS \
	    -shared -Wl,-soname,libsplit-select.so.5 \
	    -L../../libs/androidfw -landroidfw \
	    -L../aapt -laapt \
	    -L/usr/lib/android -lutils
	ln -s libsplit-select.so.${UPSTREAM_LIBVERSION} libsplit-select.so
	ln -s libsplit-select.so.${UPSTREAM_LIBVERSION} libsplit-select.so.5