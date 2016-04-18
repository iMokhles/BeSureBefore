#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <sys/cdefs.h>
#include <substrate.h>
#include <notify.h>
#import <AudioToolbox/AudioToolbox.h>

// Apllications IDS
#define BBM_ID       @"com.blackberry.bbm1"
#define INSTAGRAM_ID @"com.burbn.instagram"
#define FBM_ID       @"com.facebook.Messenger"
#define VIBER_ID     @"com.viber"
#define APSMS_ID     @"com.apple.MobileSMS"
#define TWTBOT_ID    @"com.tapbots.Tweetbot3"
#define FTIME_ID     @"com.apple.facetime"
#define MMAIL_ID     @"com.apple.mobilemail"
#define SKYPE_ID     @"com.skype.skype"
#define MPHONE_ID    @"com.apple.mobilephone"
#define WHATSAPP_ID  @"net.whatsapp.WhatsApp"

// Settings Keys
#define SMSASKKEY     @"smsAsk"
#define BBMASKKEY     @"bbmASK"
#define FTASKKEY      @"ftASK"
#define INSTASKKEY    @"instaASK"
#define FBMASKKEY     @"fbmASK"
#define VIBRASKKEY    @"viberASK"
#define TWTBOTASKKEY @"twtbotASK"
#define MAILASKKEY    @"mailASK"
#define SKYASKKEY     @"skypeASK"
#define PHONEASKKEY   @"phoneASK"
#define WHATSASKKEY   @"whatsASK"

// Advanced Settings Keys
#define SOUNDASKKEY   @"soundASK"
#define VIBASKKEY     @"vibASK"

//Pref file location
#define ASKPREFSPATH  @"/var/mobile/Library/Preferences/com.imokhles.besurebeforeprefs.plist"

// Settings
#define GET_BOOL(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).boolValue : default)
#define GET_FLOAT(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).floatValue : default)
#define GET_INT(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).intValue : default)

@interface AVAudioPlayer : NSObject
@property int numberOfLoops;
@property float volume;
- (BOOL)play;
- (id)initWithData:(id)arg1 error:(id *)arg2;
@end


@interface BeSureBeforeClass : NSObject <UIAlertViewDelegate>
@end

// Advanced Options
static BOOL soundAlertBOOL = NO;
static BOOL vibraAlertBOOL = NO;

// SMS Options
static BOOL smsASKBOOL = NO;

// FaceTime Options
static BOOL ftASKBOOL = NO;

// WhatsApp Options
static BOOL whatsASKBOOL = NO;

// Phone Options
static BOOL phoneASKBOOL = NO;

// Viber Options
static BOOL viberASKBOOL = NO;

// FBMessanger Options
static BOOL fbmASKBOOL = NO;

// Mail Options
static BOOL mailASKBOOL = NO;

// Skype Options
static BOOL skypeASKBOOL = NO;

// Instagram Options
static BOOL instaASKBOOL = NO;

// TweetBot Options
static BOOL twtbotASKBOOL = NO;

// BBM Options
static BOOL bbmASKBOOL = NO;

// MY BOOL
static BOOL besureBeforeConfirmed = NO;

static BOOL isFirstRun;