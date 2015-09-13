#import "Preferences/PSListController.h"
#import "Preferences/PFPrefCells.h"
#import "Preferences/NSTask.h"
#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <UIKit/UIKit.h>
#import "Preferences/PFInfoViewController.h"

#define kUrl_FollowOnTwitter @"https://twitter.com/imokhles"
#define kUrl_VisitWebSite @"http://imokhles.com"
#define kUrl_MakeDonation @"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=F4ZGWKWBKT82Y"

#define GlobColor [UIColor colorWithRed: 99.0/255.0 green: 99.0/255.0 blue: 255.0/255.0 alpha: 1.0]
#define kBeSureBeforeSettingsFile [NSString stringWithFormat:@"%@/Library/Preferences/%@.plist", NSHomeDirectory(), SETTINGSFILE]
#define SETTINGSFILE @"com.imokhles.besurebeforeprefs"

#define LOCLIZE_VERSION_KEY @"VERSION"

#define FOLLOW_KEY @"IMOKHLES"
#define VSITE_KEY @"IMOKHLESSITE"
#define DONATTO_KEY @"DONATETO"

// Notification
static CFNotificationCenterRef darwinNotifyCenter = CFNotificationCenterGetDarwinNotifyCenter();

// Settings Keys
static NSString *const kSMSAskKey = @"smsASK";
static NSString *const kBBMAskKey = @"bbmASK";
static NSString *const kFTAskKey = @"ftASK";
static NSString *const kINSTAskKey = @"instaASK";
static NSString *const kFBMAskKey = @"fbmASK";
static NSString *const kVIBRAskKey = @"viberASK";
static NSString *const kTWTBOTAskKey = @"twtbotASK";
static NSString *const kMAILAskKey = @"mailASK";
static NSString *const kSKYAskKey = @"skypeASK";
static NSString *const kPHONEAskKey = @"phoneASK";
static NSString *const kWHATSAskKey = @"whatsASK";

// Advanced Settings Keys
static NSString *const kSoundAskKey = @"soundASK";
static NSString *const kVIBAskKey = @"vibASK";

#define yearMade @"2014"

static NSBundle* getBundle() {
    return [NSBundle bundleWithPath:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle"];
}

@interface BeSureBeforePrefsListController: PSListController {
	NSMutableDictionary *settingsDictionary;
	PSSpecifier *banner;
	PSSpecifier *soundEnablespecifier;
	PSSpecifier *vibrationEnablespecifier;
	PSSpecifier *smsEnablespecifier;
	PSSpecifier *bbmEnablespecifier;
	PSSpecifier *facetimeEnablespecifier;
	PSSpecifier *instagramEnablespecifier;
	PSSpecifier *facebookMEnablespecifier;
	PSSpecifier *viberEnablespecifier;
	PSSpecifier *tweetbotEnablespecifier;
	PSSpecifier *mailEnablespecifier;
	PSSpecifier *skypeEnablespecifier;
	PSSpecifier *phoneEnablespecifier;
	PSSpecifier *whatsEnablespecifier;

	PSSpecifier *followCell;
    PSSpecifier *vSiteCell;
    PSSpecifier *donateToCell;
    PSSpecifier *versionCell;

	PSSpecifier *spacer;
	PSSpecifier *footer;

	BOOL soundAlertBOOL;
	BOOL vibraAlertBOOL;
	BOOL smsASKBOOL;
	BOOL ftASKBOOL;
	BOOL whatsASKBOOL;
	BOOL phoneASKBOOL;
	BOOL viberASKBOOL;
	BOOL fbmASKBOOL;
	BOOL mailASKBOOL;
	BOOL skypeASKBOOL;
	BOOL instaASKBOOL;
	BOOL twtbotASKBOOL;
	BOOL bbmASKBOOL;
}
- (void)setPreferenceValue:(id)value specifier:(id)specifier;
@end

@implementation BeSureBeforePrefsListController

- (id)init {
	if (self = [super init]) settingsDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[kBeSureBeforeSettingsFile stringByExpandingTildeInPath]];
	return self;
}

- (id)specifiers {
	if(_specifiers == nil) {
		banner = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSStaticTextCell edit:nil];
	    [banner setProperty:@100 forKey:@"height"];
	    [banner setProperty:[PFHeaderCell class] forKey:@"cellClass"]; // you can get it from github somehow :P
	    [banner setProperty:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/banner.png" forKey:@"image"];
	    [banner setProperty:@"#6363FF" forKey:@"background"];

		spacer = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];

		soundEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Enable Sound" value:@"Enable Sound" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[soundEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[soundEnablespecifier setProperty:kSoundAskKey forKey:@"key"];
		[soundEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"PostNotification"];

		vibrationEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Viberation" value:@"Viberation" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[vibrationEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[vibrationEnablespecifier setProperty:kVIBAskKey forKey:@"key"];
		[vibrationEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		facebookMEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"FBMessanger" value:@"FBMessanger" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[facebookMEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[facebookMEnablespecifier setProperty:kFBMAskKey forKey:@"key"];
		[facebookMEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		whatsEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"WhatsApp" value:@"WhatsApp" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[whatsEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[whatsEnablespecifier setProperty:kWHATSAskKey forKey:@"key"];
		[whatsEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		bbmEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"BBM" value:@"BBM" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[bbmEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[bbmEnablespecifier setProperty:kBBMAskKey forKey:@"key"];
		[bbmEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		tweetbotEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"TweetBot3" value:@"TweetBot3" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[tweetbotEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[tweetbotEnablespecifier setProperty:kTWTBOTAskKey forKey:@"key"];
		[tweetbotEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		skypeEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Skype" value:@"Skype" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[skypeEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[skypeEnablespecifier setProperty:kSKYAskKey forKey:@"key"];
		[skypeEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		instagramEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Instagram" value:@"Instagram" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[instagramEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[instagramEnablespecifier setProperty:kINSTAskKey forKey:@"key"];
		[instagramEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		facetimeEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"FaceTime" value:@"FaceTime" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[facetimeEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[facetimeEnablespecifier setProperty:kFTAskKey forKey:@"key"];
		[facetimeEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		phoneEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Phone" value:@"Phone" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[phoneEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[phoneEnablespecifier setProperty:kPHONEAskKey forKey:@"key"];
		[phoneEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		mailEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Mail" value:@"Mail" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[mailEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[mailEnablespecifier setProperty:kMAILAskKey forKey:@"key"];
		[mailEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		viberEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"Viber" value:@"Viber" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[viberEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[viberEnablespecifier setProperty:kVIBRAskKey forKey:@"key"];
		[viberEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		smsEnablespecifier = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:@"SMS" value:@"SMS" table:@"BeSureBeforePrefs"] target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
		[smsEnablespecifier setProperty:SETTINGSFILE forKey:@"defaults"];
		[smsEnablespecifier setProperty:kSMSAskKey forKey:@"key"];
		[smsEnablespecifier setProperty:@"com.imokhles.besurebeforeprefs/ReloadPrefs" forKey:@"postNotification"];

		versionCell = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:LOCLIZE_VERSION_KEY value:LOCLIZE_VERSION_KEY table:@"BeSureBeforePrefs"] target:self set:nil get:@selector(versionValue:) detail:nil cell:PSTitleValueCell edit:nil];
		[versionCell setProperty:@"0" forKey:@"hasIcon"];

		followCell = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:FOLLOW_KEY value:FOLLOW_KEY table:@"BeSureBeforePrefs"] target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
		[followCell setProperty:@"1" forKey:@"hasIcon"];
        [followCell setAction:@selector(followOnTwitter:)];
        [followCell setProperty:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Twitter.png" forKey:@"icon"];
		[followCell setupIconImageWithPath:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Twitter.png"];
        
        vSiteCell = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:VSITE_KEY value:VSITE_KEY table:@"BeSureBeforePrefs"] target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
		[vSiteCell setProperty:@"1" forKey:@"hasIcon"];
        [vSiteCell setAction:@selector(visitWebSite:)];
        [vSiteCell setProperty:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Site.png" forKey:@"icon"];
		[vSiteCell setupIconImageWithPath:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Site.png"];
        
        donateToCell = [PSSpecifier preferenceSpecifierNamed:[getBundle() localizedStringForKey:DONATTO_KEY value:DONATTO_KEY table:@"BeSureBeforePrefs"] target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
		[donateToCell setProperty:@"1" forKey:@"hasIcon"];
        [donateToCell setAction:@selector(makeDonation:)];
		[donateToCell setProperty:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Donate.png" forKey:@"icon"];
		[donateToCell setupIconImageWithPath:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Donate.png"];

		_specifiers = [[NSArray arrayWithObjects:banner,
		 spacer, 
		 [self footerSOUNDVIB],
		 soundEnablespecifier, 
		 vibrationEnablespecifier,
		 spacer,
		 [self footerFBM],
		 facebookMEnablespecifier,
		 spacer,
		 [self footerWHATS],
		 whatsEnablespecifier,
		 spacer,
		 [self footerBBM],
		 bbmEnablespecifier,
		 spacer,
		 [self footerTWTBOT],
		 tweetbotEnablespecifier,
		 spacer,
		 [self footerSKYP],
		 skypeEnablespecifier,
		 spacer,
		 [self footerINSTA],
		 instagramEnablespecifier,
		 spacer,
		 [self footerFACET],
		 facetimeEnablespecifier,
		 spacer,
		 [self footerPHONE],
		 phoneEnablespecifier,
		 spacer,
		 [self footerMAIL],
		 mailEnablespecifier,
		 spacer,
		 [self footerSMS],
		 smsEnablespecifier,
		 spacer,
		 [self footerVIBER],
		 viberEnablespecifier,
		 spacer,
		 versionCell,
		 spacer,
		 followCell,
		 vSiteCell,
		 donateToCell,
		 [self footer], 
		 nil] retain];

	}
	return _specifiers;
}
- (PSSpecifier *)footerSOUNDVIB {
	PSSpecifier *footerSOUNDVIB = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerSOUNDVIB setProperty:[getBundle() localizedStringForKey:@"SOUND_FOOTER" value:@"SOUND_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerSOUNDVIB setProperty:@"1" forKey:@"footerAlignment"];
    return footerSOUNDVIB;
}
- (PSSpecifier *)footerFBM {
	PSSpecifier *footerFBM = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerFBM setProperty:[getBundle() localizedStringForKey:@"FBM_FOOTER" value:@"FBM_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerFBM setProperty:@"1" forKey:@"footerAlignment"];
    return footerFBM;
}
- (PSSpecifier *)footerWHATS {
	PSSpecifier *footerWHATS = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerWHATS setProperty:[getBundle() localizedStringForKey:@"WHATS_FOOTER" value:@"WHATS_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerWHATS setProperty:@"1" forKey:@"footerAlignment"];
    return footerWHATS;
}
- (PSSpecifier *)footerBBM {
	PSSpecifier *footerBBM = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerBBM setProperty:[getBundle() localizedStringForKey:@"BBM_FOOTER" value:@"BBM_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerBBM setProperty:@"1" forKey:@"footerAlignment"];
    return footerBBM;
}
- (PSSpecifier *)footerTWTBOT {
	PSSpecifier *footerTWTBOT = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerTWTBOT setProperty:[getBundle() localizedStringForKey:@"TWET_FOOTER" value:@"TWET_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerTWTBOT setProperty:@"1" forKey:@"footerAlignment"];
    return footerTWTBOT;
}
- (PSSpecifier *)footerSKYP {
	PSSpecifier *footerSKYP = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerSKYP setProperty:[getBundle() localizedStringForKey:@"SKYP_FOOTER" value:@"SKYP_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerSKYP setProperty:@"1" forKey:@"footerAlignment"];
    return footerSKYP;
}
- (PSSpecifier *)footerINSTA {
	PSSpecifier *footerINSTA = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerINSTA setProperty:[getBundle() localizedStringForKey:@"INSTA_FOOTER" value:@"INSTA_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerINSTA setProperty:@"1" forKey:@"footerAlignment"];
    return footerINSTA;
}
- (PSSpecifier *)footerFACET {
	PSSpecifier *footerFACET = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerFACET setProperty:[getBundle() localizedStringForKey:@"FACETIME_FOOTER" value:@"FACETIME_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerFACET setProperty:@"1" forKey:@"footerAlignment"];
    return footerFACET;
}
- (PSSpecifier *)footerPHONE {
	PSSpecifier *footerPHONE = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerPHONE setProperty:[getBundle() localizedStringForKey:@"PHONE_FOOTER" value:@"PHONE_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerPHONE setProperty:@"1" forKey:@"footerAlignment"];
    return footerPHONE;
}
- (PSSpecifier *)footerMAIL {
	PSSpecifier *footerMAIL = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerMAIL setProperty:[getBundle() localizedStringForKey:@"MAIL_FOOTER" value:@"MAIL_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerMAIL setProperty:@"1" forKey:@"footerAlignment"];
    return footerMAIL;
}
- (PSSpecifier *)footerSMS {
	PSSpecifier *footerSMS = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerSMS setProperty:[getBundle() localizedStringForKey:@"SMS_FOOTER" value:@"SMS_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerSMS setProperty:@"1" forKey:@"footerAlignment"];
    return footerSMS;
}
- (PSSpecifier *)footerVIBER {
	PSSpecifier *footerVIBER = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerVIBER setProperty:[getBundle() localizedStringForKey:@"VIBER_FOOTER" value:@"VIBER_FOOTER" table:@"BeSureBeforePrefs"] forKey:@"footerText"];
    [footerVIBER setProperty:@"1" forKey:@"footerAlignment"];
    return footerVIBER;
}

- (PSSpecifier *)footer {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects: @"-c", @"dpkg -s com.imokhles.besurebefore | grep 'Version'", nil]];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task launch];
    
    NSTask *taskAuth = [[NSTask alloc] init];
    [taskAuth setLaunchPath: @"/bin/sh"];
    [taskAuth setArguments:[NSArray arrayWithObjects: @"-c", @"dpkg -s com.imokhles.besurebefore | grep 'Author'", nil]];
    NSPipe *pipeAuth = [NSPipe pipe];
    [taskAuth setStandardOutput:pipeAuth];
    [taskAuth launch];

    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSData *dataAuth = [[[taskAuth standardOutput] fileHandleForReading] readDataToEndOfFile];

    NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSString *author = [[NSString alloc] initWithData:dataAuth encoding:NSASCIIStringEncoding];
    NSString *subString = [author substringFromIndex:[author length] - 9];
	[task release];
	//[pipe release]; //crashes

    footer = [PSSpecifier preferenceSpecifierNamed:@"" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
    [footer setProperty:[NSString stringWithFormat:@"© %@ %@ All rights reserved",subString, [self dynamicYear]] forKey:@"footerText"];
    [footer setProperty:@"1" forKey:@"footerAlignment"];

	//[data release]; crashes
	[version release];

    return footer;
}

- (NSString *)dynamicYear {
   
    NSString *dynamicYear = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if([yearMade isEqual:dateString]){
    dynamicYear = dateString;
    } else {
    dynamicYear = [NSString stringWithFormat:@"%@ - %@", yearMade, dateString];
    }
   [dateFormatter release];

	return dynamicYear;
}

- (NSString *)versionValue:(PSSpecifier *)specifier {

	NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects: @"-c", @"dpkg -s com.imokhles.besurebefore | grep 'Version'", nil]];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task launch];
    NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSString *subString = [version substringFromIndex:[version length] - 6];
	[task release];
	//[pipe release]; //crashes
    
	return subString;
}
- (void)followOnTwitter:(PSSpecifier*)specifier {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_FollowOnTwitter]];
}

- (void)visitWebSite:(PSSpecifier*)specifier {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_VisitWebSite]];
}

- (void)makeDonation:(PSSpecifier *)specifier {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kUrl_MakeDonation]];
}
- (void)setPreferenceValue:(id)value specifier:(id)specifier {
    [super setPreferenceValue:value specifier:specifier];

    NSString *notification = [specifier propertyForKey:@"postNotification"];
    if(notification) {
        CFNotificationCenterPostNotification(darwinNotifyCenter, (CFStringRef)notification, NULL, NULL, true);
    }
}

- (void)loadView
{
	UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/BeSureBeforePrefs.bundle/Twitter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTapped:)];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0.0);
	UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[tweet setBackgroundImage:blank forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	self.navigationItem.rightBarButtonItem = tweet;

	//[blank release]; releasing this seems to cause crashes after a while >.>
	[tweet release];

	[super loadView];
}
- (void)viewWillAppear:(BOOL)animated
{
	[UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = GlobColor;
	[[UISwitch appearanceWhenContainedIn:self.class, nil] setOnTintColor:GlobColor];
	self.view.tintColor = GlobColor;
	self.navigationController.navigationBar.tintColor = GlobColor;

	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	self.view.tintColor = nil;
	self.navigationController.navigationBar.tintColor = nil;
}

- (void)shareTapped:(UIBarButtonItem *)sender {
	// #BeSureBefore by @iMokhles avoid to proceed operations mistakenly!
	SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; // this is autoreleased!
	[composeController setInitialText:@"#BeSureBefore by @iMokhles avoid me from proceed operations mistakenly!"];
	[self presentViewController:composeController animated:YES completion:nil];
}
@end

// vim:ft=objc
