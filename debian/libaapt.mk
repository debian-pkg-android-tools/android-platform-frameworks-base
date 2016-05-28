NAME = libaapt
SOURCES = AaptAssets.cpp \
          AaptConfig.cpp \
          AaptUtil.cpp \
          AaptXml.cpp \
          ApkBuilder.cpp \
          Command.cpp \
          CrunchCache.cpp \
          FileFinder.cpp \
          Images.cpp \
          Package.cpp \
          pseudolocalize.cpp \
          Resource.cpp \
          ResourceFilter.cpp \
          ResourceIdCache.cpp \
          ResourceTable.cpp \
          SourcePos.cpp \
          StringPool.cpp \
          WorkQueue.cpp \
          XMLNode.cpp \
          ZipEntry.cpp \
          ZipFile.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt/$(source))
CXXFLAGS += -std=gnu++11
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(BUILD_TOOLS_VERSION)\" \
            -include android/arch/AndroidConfig.h \
            -I/usr/include/android -Iinclude
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android:/usr/lib/android:. \
           -lpng -lexpat -lz \
           -L/usr/lib/android -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -llog -lutils \
           -L. -landroidfw \

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*