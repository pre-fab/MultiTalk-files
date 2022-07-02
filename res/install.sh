#!/bin/sh
KAKAO=/Applications/KakaoTalk.app
CLONE=/Applications/KakaoTalkMulti.app

if [ ! -e "$KAKAO" ]
then
	echo "Please run after installing KakaoTalk."
	exit 0
fi

if [ -e "$CLONE" ]
then
	rm -rf "$CLONE"
fi

if [ -e "$CLONE" ]
then
	rm -rf "$CLONE"
fi

cp -a "$KAKAO" "$CLONE"
mv "/Applications/KakaoTalkMulti.app/Contents/MacOS/KakaoTalk" "/Applications/KakaoTalkMulti.app/Contents/MacOS/KakaoTalk Multi"
cd "/Applications/KakaoTalkMulti.app/Contents/"

sed -i '' "s/KakaoTalk<\/string>/KakaoTalk Multi<\/string>/g" Info.plist
sed -i '' "s/kakaoTalk<\/string>/kakaoTalk Multi<\/string>/g" Info.plist

sed -i '' "s/<string>KakaoTalk needs/<string>KakaoTalk Multi needs/g" Info.plist
sed -i '' "s/on KakaoTalk.<\/string>/on KakaoTalk Multi.<\/string>/g" Info.plist

sed -i '' "s/com.kakao.KakaoTalkMac<\/string>/com.kakao.KakaoTalkMultiMac<\/string>/g" Info.plist

curl -o "/Applications/KakaoTalkMulti.app/Contents/Resources/en.lproj/InfoPlist.strings" "https://raw.githubusercontent.com/pre-fab/MultiTalk-files/main/res/en.strings"
curl -o "/Applications/KakaoTalkMulti.app/Contents/Resources/ja.lproj/InfoPlist.strings" "https://raw.githubusercontent.com/pre-fab/MultiTalk-files/main/res/ja.strings"
curl -o "/Applications/KakaoTalkMulti.app/Contents/Resources/ko.lproj/InfoPlist.strings" "https://raw.githubusercontent.com/pre-fab/MultiTalk-files/main/res/ko.strings"

xattr -cr "$CLONE"
codesign --force --deep --sign - "$CLONE"

open "$CLONE"