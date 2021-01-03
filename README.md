sfa3_support v1.0<br>
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
　<img src="./pic/mame_cps2_00.png" height="360"><br>
　<img src="./pic/mame_ps1_00.png" height="360"><br>
　<img src="./pic/mame_gba_00.png" height="360"><br>
<br>
・MAME Rerecording[mame-rr-0139-test2]<br>
　https://code.google.com/archive/p/mame-rr/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/mamerr_cps2_00.png" height="360"><br>
<br>
・FinalBurn Alpha Rerecording[fba-rr-v007]<br>
　https://code.google.com/archive/p/fbarr/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/fbarr_cps2_00.png" height="360"><br>
<br>
・FightCade2[FBNeo v0.2.97.44-30]<br>
　https://www.fightcade.com/<br>
　CPS2版で利用可能。<br>
　<img src="./pic/fcfbneo_cps2_00.png" height="360"><br>
<br>
・Bizhawk[BizHawk-2.4.2]<br>
　http://tasvideos.org/BizHawk.html<br>
　SS版、PS版、GBA版で利用可能。<br>
　<img src="./pic/bizhawk_ss_00.png" height="360"><br>
　<img src="./pic/bizhawk_ps1_00.png" height="360"><br>
　<img src="./pic/bizhawk_gba_00.png" height="360"><br>
<br>
・PSXjin[psxjinv2.0.2]<br>
　https://www.emutopia.com/index.php/emulators/item/299-sony-playstation/423-psxjin<br>
　PS版で利用可能。<br>
　<img src="./pic/psxjin_ps1_00.png" height="360"><br>
<br>
・VBA-ReRecording[vba-rerecording-svn480-win32]<br>
　https://code.google.com/archive/p/vba-rerecording/<br>
　GBA版で利用可能。<br>
　<img src="./pic/vbarr_gba_00.png" height="360"><br>
<br>
・PCSX2-RR[PCSX2-rr_v1.0.1]<br>
　https://github.com/xTVaser/pcsx2-rr<br>
　PS2版で利用可能。<br>
　<img src="./pic/pcsx2rrlua_ps2_00.png" height="360"><br>
<br>
<br>
【その他設定】<br>
・config.luaのcにて描画遅延設定や描画色の指定等を変更することが出来る。<br>
・program.luaのcheatにて、STATIC CHEATの設定を追加、変更することが出来る。<br>
<br>
<br>
【既知の不具合や仕様】<br>
・エミュレータによっては映像に対して表示される判定や値が同期されないことがある。<br>
　推奨エミュレータはMAME。次いでMAME-RR。MAMEはデータの取得タイミングも最適化されている模様。<br>
・MAME使用時に文字の幅がずれたり、画面端付近のデータ等が画面内に無理やり表示されたりする。<br>
　これはフォントにプロポーショナルフォントが使用されていたり、エミュレータの仕様によるもの。<br>
・Bizhawk＋SS版の環境にて、キャラIDの値が大きいキャラ(例：ユーニ)の攻撃判定が表示されない。また、動作が非常に重い。<br>
・一部のエミュレータや環境によっては投げ判定が表示されない。理由は技術的な問題やエミュレータの仕様など様々。<br>
　投げ判定を表示させるには複雑な処理が必要なため、特定の条件や設定を行わなければならず、敷居が高い。<br>
　とにかく表示させたいという場合はMAMEかMAME-RRにて980904の使用が簡単でおすすめ。<br>
　980904はROMの作りが他と若干異なっており、表示が簡単な構造になっているため。<br>
　解析者向け情報として、config.luaのcにてclear_idがtrueの場合、メモリの一部を書き換えて間借りすることによって<br>
　投げ判定表示を実現している。MAMEを使い、clear_idをfalse、debug_coopをtrueにした上で「-debug」を有効にすると<br>
　メモリの書き換え無しに投げ判定表示が可能となる。<br>
　他にも様々な方法で投げ判定を表示させる手法を組み込んであるため、要望があれば詳しく解説するかもしれません。<br>
・動作時にMAMEをリセットするとスクリプトも再度読み込まれ、スクリプトが多重に起動され動作が重くなる<br>
・etc...思い出したりしたら追記していきます。<br>
<br>
<br>
【表示内容】<br>
　<img src="./pic/pic01.png" height="520"><br>
・HITBOX関連<br>
　橙:キャラクターや飛び道具等が存在する座標の中心点を表示。<br>
　青:存在判定。押し合い判定とも呼ばれる。キャラ同士が同じ座標に重ならないようにするための判定。<br>
　黄:頭部喰らい判定。3つある喰らい判定のうち、頭部に割り当てられる事が多い。のけぞり方(上のけぞり)に影響する特殊な判定。<br>
　緑:胴部喰らい判定。3つある喰らい判定のうち、胴部に割り当てられる事が多い。<br>
　紫:脚部喰らい判定。3つある喰らい判定のうち、脚部に割り当てられる事が多い。<br>
　赤:攻撃判定。この判定が相手の喰らい判定に接触するとヒットとなる。<br>
　白:投げ判定。この判定が相手の存在判定に接触すると投げが成立する。ただし、投げは処理が特殊なため例外が沢山存在する。<br>
　桃:飛び道具攻撃判定。この判定が相手の喰らい判定に接触するとヒットとなる。<br>
　水:飛び道具喰らい判定。この判定が相手の飛び道具攻撃判定に接触すると相殺となる。<br>
　紅:テイクノープリズナーの攻撃判定。<br>
　※ZERO3には投げられ判定と呼ばれるものは存在しない。投げは存在判定といくつかの設定値を参照し、結果が決定される。<br>
<br>
・Invincible<br>
　左から順に無敵フラグ、投げによる無敵、ピヨりによる無敵、時限無敵を表示。<br>
　無敵フラグ:画面端のヒット制限発生時等に有効となる。画面端のよくある無敵化はこれが関係。<br>
　投げによる無敵:投げ動作中に有効となる。投げた側は赤、投げられた側は黄色で表示。投げ抜けによる無敵化はこれが関係。<br>
　ピヨりによる無敵:ピヨり吹き飛び時に有効となる。存在判定投げでも投げられない無敵化。<br>
　時限無敵:SCやOCに代表される有限の無敵時間。空中ガード後着地した瞬間にも1Fの時限無敵が設定される。<br>
<br>
・NoThrow<br>
　投げ不能時間を表示。<br>
　リバーサル時やジャンプ移行動作等、いろいろな場面で設定される。<br>
<br>
・TURBO<br>
　ターボ設定を表示。<br>
　値が大きいほどターボがかかる。0:ノーマル、6:ターボ1、8：ターボ2。<br>
　チートした場合、最大0x0F(2Fに1回フレームスキップ)まで高速化する。<br>
　直下に残りタイムと残りタイム(フレーム)を表示<br>
<br>
・Freeze<br>
　攻撃によるヒットストップや時間停止による行動不能時間を表示。<br>
<br>
・Block<br>
　連続ガード回数を表示。<br>
　インフレに関係。<br>
<br>
・CC<br>
　残りOC時間を表示。<br>
　CCは海外でのOCの名称であるCustomComboの略。<br>
<br>
・Anim<br>
　アニメーションデータへのポインタを表示。<br>
　ポインタの先にグラフィックポインタや攻撃判定等様々な情報へアクセスできる。解析者向け。<br>
<br>
・Vital<br>
　残り体力を表示。<br>
　左側に現在残り体力、右側にMAX値を表示。<br>
　現在残り体力は0～144の145段階となる。KO時は値が-1になる。<br>
<br>
・Combo<br>
　コンボ数を表示。<br>
　左に現在コンボ数、右にMAXコンボ数を表示。<br>
<br>
・Stun<br>
　ピヨり値関連を表示。<br>
　例えば174-> 2/ 40->---と表示されている場合はピヨり初期化までの時間が174フレームで<br>
　蓄積されたピヨり値が2、ピヨり耐久値が40となる。<br>
　ピヨった場合、「---」の部分に残りピヨリ時間が表示される。<br>
<br>
・Guard<br>
　ガードクラッシュ関連値を表示。<br>
　例えば21->10/60-> 0と表示されている場合はガードゲージ回復までの時間が21フレームで<br>
　蓄積されたガードクラッシュ値が10、ガードクラッシュ耐久値が60となる。<br>
　ガードクラッシュした場合、「 0」の部分に残りガードクラッシュ時間が表示される。<br>
　※内部的には「値の増加」によってガークラが発生するよう作られていたため、そのまま表示しています。<br>
<br>
・X,Y<br>
　キャラクターの座標を表示。<br>
　「.」の左側に10進数の整数を、「.」の右側に16進数のサブピクセル値を表示する特殊な形式を採用した。<br>
　サブピクセルとは整数で表されるピクセル値より更に小さい内部値のこと。<br>
　座標が781.7B00, 40.0000の場合、X座標は781とサブピクセル値0x7B00であり、Y座標は40ピッタリであることを示す。<br>
　例えば右に100.8000移動する技があった場合、500.8000の位置から100.8000移動すると<br>
　足し合わせて601.0000の位置に移動することになり、整数部分だけを足し合わせた結果の100+500より大きくなる。<br>
<br>
・Close<br>
　キャラクター同士の接触フラグを表示。<br>
　歩いて密着したはずなのに存在判定重複防止処理により密着出来ない場合があるが<br>
　このフラグを見れば実際に接触しているかどうかがわかる。<br>
<br>
・Direction<br>
　キャラクターの向いている方向を表示。<br>
<br>
・Corner<br>
　キャラクターの位置を表示。<br>
　<:左画面端に接触<br>
　-:画面端に接触していない<br>
　>:右画面端に接触<br>
<br>
・Power<br>
　残りゲージを表示。<br>
　左側に現在残りゲージ、右側にMAX値を表示。<br>
　現在残りゲージは0～144の145段階となる。<br>
<br>
・Left<br>
　現在のアニメーションの残りフレームを表示。<br>
<br>
・Motion<br>
　現在のモーションを表示。<br>
　例えばニュートラルモーションはNeutral、しゃがみ中はSit、リバーサルはReversal<br>
<br>
・Status<br>
　現在のステータスを表示。<br>
　例えば地上時はGround、ジャンプ時はMid Air<br>
<br>
・Input<br>
　現在の入力を表示。<br>
　上:^ 左:< 下:v 右:> 弱P:青P 中P:黄P 強P:赤P 弱K:青K 中K:黄K 強K:赤K Coin:C Start:S Test:T<br>
<br>
<br>
【修正履歴】<br>
v1.0<br>
・MAME 0.227の新しい形式のLua APIに追加対応。<br>
v0.9<br>
・1st release
