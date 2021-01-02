sfa3_support v0.9<br>
<br>
【はじめに】<br>
本スクリプトはStreet Fighter ZERO3(ALPHA3)の判定等の内部データを表示する機能を搭載しています。<br>
スクリプトを作るにあたって、有益な情報を発信しておられた下記の方たちにお礼を申し上げます。<br>
<br>
・mauzus様、dammit9x様、並びにmame-rrとfba-rrと様々なluaスクリプト開発に関わった方々<br>
　これらの方々の功績により全てが始まったと言っても過言では有りません。<br>
　https://code.google.com/archive/p/mame-rr/<br>
　https://code.google.com/archive/p/fbarr/<br>
<br>
・jed様<br>
　様々な情報提供をして頂きました。<br>
　https://twitter.com/mountainmanjed<br>
<br>
・各エミュレータ開発者様<br>
　luaengineの機能により、様々なことが実現出来ました。<br>
<br>
・さらだ様<br>
　開発中バージョンにおける様々な検証や、アイデア提供を行っていただきました。<br>
<br>
・全てのZERO3プレイヤー様<br>
　日々提供される攻略情報等、非常に役立ちました。<br>
<br>
<br>
【使い方】<br>
・エミュレータ本体と同じフォルダにsfa3_support.luaとsubフォルダを置き、sfa3_support.luaを読み込ませる。<br>
　MAMEの場合は起動時のオプションに「-autoboot_script」を使うことで読み込める。<br>
　例：mame64.exe sfz3jr2 -rompath "C:\SF30thROM" -autoboot_script "sfa3_support.lua"<br>
・CPS2版の場合はキーボードのShiftを推しながらEnterを押すことで拡張機能メニューのオンオフが出来る。<br>
　拡張機能はキーボードの上下左右を操作することによって設定を変更することが出来る。<br>
　拡張機能の一部の機能はエミュレータの仕様によって利用可否に差がある。ちなみにMAMEは全ての機能を利用可能。<br>
<br>
<br>
【動作確認環境】<br>
・MAME[mame0200b_64bit]<br>
　https://www.mamedev.org/<br>
　CPS2版、PS版、GBA版で利用可能。<br>
　<img src="./pic/mame_cps2_00.png" height="240"><br>
　<img src="./pic/mame_ps1_00.png" height="240"><br>
　<img src="./pic/mame_gba_00.png" height="240"><br>
<br>
・MAME Rerecording[mame-rr-0139-test2]<br>
　https://code.google.com/archive/p/mame-rr/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/mamerr_cps2_00.png" height="240"><br>
<br>
・FinalBurn Alpha Rerecording[fba-rr-v007]<br>
　https://code.google.com/archive/p/fbarr/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/fbarr_cps2_00.png" height="240"><br>
<br>
・FightCade2[FBNeo v0.2.97.44-30]<br>
　https://www.fightcade.com/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/fcfbneo_cps2_00.png" height="240"><br>
<br>
・Bizhawk[BizHawk-2.4.2]<br>
　http://tasvideos.org/BizHawk.html<br>
　SS版、PS版、GBA版で利用可能。<br>
　<img src="./pic/bizhawk_ss_00.png" height="240"><br>
　<img src="./pic/bizhawk_ps1_00.png" height="240"><br>
　<img src="./pic/bizhawk_gba_00.png" height="240"><br>
<br>
・PSXjin[psxjinv2.0.2]<br>
　https://www.emutopia.com/index.php/emulators/item/299-sony-playstation/423-psxjin<br>
　PS版で利用可能。<br>
　<img src="./pic/psxjin_ps1_00.png" height="240"><br>
<br>
・VBA-ReRecording[vba-rerecording-svn480-win32]<br>
　https://code.google.com/archive/p/vba-rerecording/<br>
　GBA版で利用可能。<br>
　<img src="./pic/vbarr_gba_00.png" height="240"><br>
<br>
・PCSX2-RR[PCSX2-rr_v1.0.1]<br>
　https://github.com/xTVaser/pcsx2-rr<br>
　PS2版で利用可能。<br>
　<img src="./pic/pcsx2rrlua_ps2_00.png" height="240"><br>
<br>
<br>
【その他設定】<br>
・config.luaのcにて描画遅延設定や描画色の指定等を変更することが出来る。<br>
・program.luaのcheatにて、STATIC CHEATの設定を追加、変更することが出来る。<br>
<br>
<br>
【既知の不具合や仕様】<br>
・エミュレータによっては映像に対して表示される判定や値が同期されないことがある。推奨エミュレータはMAME。次いでMAME-RR。<br>
・MAME使用時に文字の幅がずれたり、画面端付近のデータ等が画面内に無理やり表示されたりする。<br>
　これはフォントにプロポーショナルフォントが使用されていたり、エミュレータの仕様によるもの。<br>
・Bizhawk＋SS版の環境にて、キャラIDの値が大きいキャラ(例：ユーニ)の攻撃判定が表示されない。また、動作が非常に重い。<br>
・一部のエミュレータや環境によっては投げ判定が表示されない。理由は技術的な問題やエミュレータの仕様など様々。<br>
　投げ判定を表示させるには複雑な処理が必要なため、特定の条件や設定を行わなければならず、敷居が高い。<br>
　とにかく表示させたいという場合はMAMEかMAME-RRにて980904の使用が簡単でおすすめ。980904はROMの作りが他と若干異なり簡単であるため。<br>
　解析者向け情報としてconfig.luaのcにてclear_idがtrueの場合、メモリの一部を書き換えて間借りすることによって投げ判定表示を実現している。<br>
　MAMEを使い、clear_idをfalse、debug_coopをtrueにした上で「-debug」を有効にするとメモリの書き換え無しに投げ判定表示が可能となる。<br>
　他にも様々な方法で投げ判定を表示させる手法を組み込んであるため、要望があれば詳しく解説するかもしれません。<br>
・etc...思い出したりしたら追記していきます。<br>
<br>
<br>
【修正履歴】<br>
v0.9<br>
・1st release
