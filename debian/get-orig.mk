build:
	wget https://android.googlesource.com/platform/frameworks/base/+archive/$(UPSTREAM_TAG).tar.gz
	mkdir $(PACKAGE_NAME)-$(UPSTREAM_VERSION)
	tar -f $(UPSTREAM_TAG).tar.gz -z -x --directory $(PACKAGE_NAME)-$(UPSTREAM_VERSION)
	tar --create --xz -X ../debian/orig.excludes -f $(PACKAGE_NAME)_$(UPSTREAM_VERSION).orig.tar.xz $(PACKAGE_NAME)-$(DEBIAN_VERSION)