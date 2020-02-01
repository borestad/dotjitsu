#!/bin/bash

# IMPORTANT: Don't forget to logout from your Apple ID in the settings before running it!
# IMPORTANT: You will need to run this script from Recovery. In fact, macOS Catalina brings read-only filesystem which prevent this script from working from the main OS.
# This script needs to be run from the volume you wish to use.
# E.g. run it like this: cd /Volumes/Macintosh\ HD && sh /Volumes/Macintosh\ HD/Users/sabri/Desktop/disable.sh

# Get active services: launchctl list | grep -v "\-\t0"
# Find a service: grep -lR [service] /System/Library/Launch* /Library/Launch* ~/Library/LaunchAgents

# Agents to enable
TOENABLE=()

# iCloud
TOENABLE+=('com.apple.security.cloudkeychainproxy3' \
	'com.apple.iCloudUserNotifications' \
	'com.apple.icloud.findmydeviced.findmydevice-user-agent' \
	'com.apple.icloud.fmfd' \
	'com.apple.icloud.searchpartyuseragent' \
	'com.apple.cloudd' \
	'com.apple.cloudpaird' \
	'com.apple.cloudphotod' \
	'com.apple.followupd' \
	'com.apple.protectedcloudstorage.protectedcloudkeysyncing')

# Safari useless stuff
TOENABLE+=('com.apple.SafariBookmarksSyncAgent' \
	'com.apple.SafariCloudHistoryPushAgent' \
	'com.apple.WebKit.PluginAgent')

# iMessage / Facetime
TOENABLE+=('com.apple.imagent' \
	'com.apple.imautomatichistorydeletionagent' \
	'com.apple.imklaunchagent' \
	'com.apple.imtransferagent' \
	'com.apple.avconferenced')

# Game Center / Passbook / Apple TV / Homekit...
TOENABLE+=('com.apple.gamed' \
	'com.apple.passd' \
	'com.apple.Maps.pushdaemon' \
	'com.apple.videosubscriptionsd' \
	'com.apple.CommCenter-osx' \
	'com.apple.homed')

# Ad-related
TOENABLE+=('com.apple.ap.adprivacyd' \
	'com.apple.ap.adservicesd')

# Screensharing
TOENABLE+=('com.apple.screensharing.MessagesAgent' \
	'com.apple.screensharing.agent' \
	'com.apple.screensharing.menuextra')

# Siri
TOENABLE+=('com.apple.siriknowledged' \
	'com.apple.assistant_service' \
	'com.apple.assistantd' \
	'com.apple.Siri.agent' \
	'com.apple.parsec-fbf')

# VoiceOver / accessibility-related stuff
TOENABLE+=('com.apple.VoiceOver' \
	'com.apple.voicememod' \
	'com.apple.accessibility.AXVisualSupportAgent' \
	'com.apple.accessibility.dfrhud' \
	'com.apple.accessibility.heard')

# Quicklook
TOENABLE+=('com.apple.quicklook.ui.helper' \
	'com.apple.quicklook.ThumbnailsAgent' \
	'com.apple.quicklook')

# Sidecar
TOENABLE+=('com.apple.sidecar-hid-relay' \
	'com.apple.sidecar-relay')

# Debugging process
TOENABLE+=('com.apple.spindump_agent' \
	'com.apple.ReportCrash' \
	'com.apple.ReportGPURestart' \
	'com.apple.ReportPanic' \
	'com.apple.DiagnosticReportCleanup' \
	'com.apple.TrustEvaluationAgent')

# Screentime
TOENABLE+=('com.apple.ScreenTimeAgent' \
	'com.apple.UsageTrackingAgent')

# Others
TOENABLE+=('com.apple.telephonyutilities.callservicesd' \
	'com.apple.photoanalysisd' \
	'com.apple.parsecd' \
	'com.apple.AOSPushRelay' \
	'com.apple.AOSHeartbeat' \
	'com.apple.AirPlayUIAgent' \
	'com.apple.AirPortBaseStationAgent' \
	'com.apple.familycircled' \
	'com.apple.familycontrols.useragent' \
	'com.apple.familynotificationd' \
	'com.apple.findmymacmessenger' \
	'com.apple.sharingd' \
	'com.apple.identityservicesd' \
	'com.apple.java.InstallOnDemand' \
	'com.apple.parentalcontrols.check' \
	'com.apple.security.keychain-circle-notification' \
	'com.apple.syncdefaultsd' \
	'com.apple.appleseed.seedusaged' \
	'com.apple.appleseed.seedusaged.postinstall' \
	'com.apple.CallHistorySyncHelper' \
	'com.apple.RemoteDesktop' \
	'com.apple.CallHistoryPluginHelper' \
	'com.apple.SocialPushAgent' \
	'com.apple.touristd' \
	'com.apple.macos.studentd' \
	'com.apple.KeyboardAccessAgent' \
	'com.apple.exchange.exchangesyncd' \
	'com.apple.suggestd' \
	'com.apple.AddressBook.abd' \
	'com.apple.helpd' \
	'com.apple.amp.mediasharingd' \
	'com.apple.mediaanalysisd' \
	'com.apple.mediaremoteagent' \
	'com.apple.remindd')

for agent in "${TOENABLE[@]}"
do
    mv ./System/Library/LaunchAgents/${agent}.plist.bak ./System/Library/LaunchAgents/${agent}.plist
    echo "[OK] Agent ${agent} disabled"
done

# Daemons to enable
TOENABLE=()

# iCloud
TOENABLE+=('com.apple.analyticsd')

# Others
TOENABLE+=('com.apple.netbiosd' \
	'com.apple.preferences.timezone.admintool' \
	'com.apple.remotepairtool' \
	'com.apple.security.FDERecoveryAgent' \
	'com.apple.SubmitDiagInfo' \
	'com.apple.screensharing' \
	'com.apple.appleseed.fbahelperd' \
	'com.apple.apsd' \
	'com.apple.ManagedClient.cloudconfigurationd' \
	'com.apple.ManagedClient.enroll' \
	'com.apple.ManagedClient' \
	'com.apple.ManagedClient.startup' \
	'com.apple.locate' \
	'com.apple.locationd' \
	'com.apple.eapolcfg_auth' \
	'com.apple.RemoteDesktop.PrivilegeProxy' \
	'com.apple.mediaremoted')

for daemon in "${TOENABLE[@]}"
do
    mv ./System/Library/LaunchDaemons/${daemon}.plist.bak ./System/Library/LaunchDaemons/${daemon}.plist
    echo "[OK] Daemon ${daemon} disabled"
done
