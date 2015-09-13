include theos/makefiles/common.mk

TWEAK_NAME = BeSureBefore
BeSureBefore_FILES = Tweak.xm $(wildcard *.m)
BeSureBefore_FRAMEWORKS = UIKit AVFoundation Foundation AudioToolbox

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += besurebeforeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
