NAME = aapt2
SOURCES = compile/IdAssigner.cpp \
          compile/Png.cpp \
          compile/PseudolocaleGenerator.cpp \
          compile/Pseudolocalizer.cpp \
          compile/XmlIdCollector.cpp \
          filter/ConfigFilter.cpp \
          flatten/Archive.cpp \
          flatten/TableFlattener.cpp \
          flatten/XmlFlattener.cpp \
          io/FileSystem.cpp \
          io/ZipArchive.cpp \
          link/AutoVersioner.cpp \
          link/ManifestFixer.cpp \
          link/ProductFilter.cpp \
          link/PrivateAttributeMover.cpp \
          link/ReferenceLinker.cpp \
          link/TableMerger.cpp \
          link/XmlReferenceLinker.cpp \
          process/SymbolTable.cpp \
          proto/ProtoHelpers.cpp \
          proto/TableProtoDeserializer.cpp \
          proto/TableProtoSerializer.cpp \
          split/TableSplitter.cpp \
          unflatten/BinaryResourceParser.cpp \
          unflatten/ResChunkPullParser.cpp \
          util/BigBuffer.cpp \
          util/Files.cpp \
          util/Util.cpp \
          ConfigDescription.cpp \
          Debug.cpp \
          Flags.cpp \
          java/AnnotationProcessor.cpp \
          java/ClassDefinition.cpp \
          java/JavaClassGenerator.cpp \
          java/ManifestClassGenerator.cpp \
          java/ProguardRules.cpp \
          Locale.cpp \
          Resource.cpp \
          ResourceParser.cpp \
          ResourceTable.cpp \
          ResourceUtils.cpp \
          ResourceValues.cpp \
          SdkConstants.cpp \
          StringPool.cpp \
          xml/XmlActionExecutor.cpp \
          xml/XmlDom.cpp \
          xml/XmlPullParser.cpp \
          xml/XmlUtil.cpp \
          compile/Compile.cpp \
          dump/Dump.cpp \
          link/Link.cpp \
          Main.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt2/$(source))
SOURCES += debian/out/proto/frameworks/base/tools/aapt2/Format.pb.cc
CXXFLAGS += -fno-exceptions
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(ANDROID_BUILD_TOOLS_VERSION)\" \
            -Iinclude -Itools/aapt2 -Idebian/out
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lexpat -lpng -lprotobuf-lite \
           -Wl,-rpath-link=debian/out -Ldebian/out -landroidfw \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lutils -lbase -lziparchive

build: $(SOURCES)
	$(CXX) $^ -o debian/out/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) debian/out/$(NAME) debian/out/Format.pb.*

debian/out/proto/frameworks/base/tools/aapt2/Format.pb.cc: tools/aapt2/Format.proto
	mkdir --parents debian/out/proto/frameworks/base/tools/aapt2
	protoc --cpp_out=debian/out/proto/frameworks/base/tools/aapt2 \
	       --proto_path=tools/aapt2 $<