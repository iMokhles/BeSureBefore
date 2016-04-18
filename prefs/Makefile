include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BeSureBeforePrefs
BeSureBeforePrefs_FILES = $(wildcard *.mm) $(wildcard *.m)
BeSureBeforePrefs_INSTALL_PATH = /Library/PreferenceBundles
BeSureBeforePrefs_FRAMEWORKS = UIKit Social CoreGraphics MessageUI QuartzCore Foundation
BeSureBeforePrefs_PRIVATE_FRAMEWORKS = Preferences
BeSureBeforePrefs_LDFLAGS = -Llib -lmarquee

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BeSureBeforePrefs.plist$(ECHO_END)
