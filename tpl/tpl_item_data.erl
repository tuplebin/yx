-module(tpl_item_data).
-export([
	asset/1
	,asset_en/1
	,food/1
	,play/1
]).


asset(1) -> #{id => 1, name => <<"元晶"/utf8>>, field => <<"crystal"/utf8>>, init => 0, effect => [], type => <<>>};
asset(2) -> #{id => 2, name => <<"元卡"/utf8>>, field => <<"card"/utf8>>, init => 0, effect => [], type => <<>>};
asset(21) -> #{id => 21, name => <<"体力"/utf8>>, field => <<"physical"/utf8>>, init => 100, effect => [], type => <<"attr_base"/utf8>>};
asset(22) -> #{id => 22, name => <<"饱腹度"/utf8>>, field => <<"satiety"/utf8>>, init => 100, effect => [], type => <<"attr_base"/utf8>>};
asset(31) -> #{id => 31, name => <<"智力"/utf8>>, field => <<"intellect"/utf8>>, init => 100, effect => [], type => <<"attr_1"/utf8>>};
asset(32) -> #{id => 32, name => <<"耐力"/utf8>>, field => <<"endurance"/utf8>>, init => 100, effect => [], type => <<"attr_1"/utf8>>};
asset(33) -> #{id => 33, name => <<"感知"/utf8>>, field => <<"perception"/utf8>>, init => 100, effect => [], type => <<"attr_1"/utf8>>};
asset(34) -> #{id => 34, name => <<"魅力"/utf8>>, field => <<"charm"/utf8>>, init => 100, effect => [], type => <<"attr_1"/utf8>>};
asset(35) -> #{id => 35, name => <<"运气"/utf8>>, field => <<"luck"/utf8>>, init => 100, effect => [], type => <<"attr_1"/utf8>>};
asset(51) -> #{id => 51, name => <<"舒适值"/utf8>>, field => <<"comfort"/utf8>>, init => 0, effect => [{31, 1},{32, 1}], type => <<"attr_2"/utf8>>};
asset(52) -> #{id => 52, name => <<"快乐值"/utf8>>, field => <<"happy"/utf8>>, init => 0, effect => [{31, 1},{32, 2}], type => <<"attr_2"/utf8>>};
asset(53) -> #{id => 53, name => <<"健康值"/utf8>>, field => <<"health"/utf8>>, init => 0, effect => [{31, 1},{32, 3}], type => <<"attr_2"/utf8>>};
asset(54) -> #{id => 54, name => <<"社交值"/utf8>>, field => <<"social"/utf8>>, init => 0, effect => [{31, 1},{32, 4}], type => <<"attr_2"/utf8>>};
asset(_) -> undefined.


asset_en(<<"crystal"/utf8>>) -> #{id => 1, init => 0};
asset_en(<<"card"/utf8>>) -> #{id => 2, init => 0};
asset_en(<<"physical"/utf8>>) -> #{id => 21, init => 100};
asset_en(<<"satiety"/utf8>>) -> #{id => 22, init => 100};
asset_en(<<"intellect"/utf8>>) -> #{id => 31, init => 100};
asset_en(<<"endurance"/utf8>>) -> #{id => 32, init => 100};
asset_en(<<"perception"/utf8>>) -> #{id => 33, init => 100};
asset_en(<<"charm"/utf8>>) -> #{id => 34, init => 100};
asset_en(<<"luck"/utf8>>) -> #{id => 35, init => 100};
asset_en(<<"comfort"/utf8>>) -> #{id => 51, init => 0};
asset_en(<<"happy"/utf8>>) -> #{id => 52, init => 0};
asset_en(<<"health"/utf8>>) -> #{id => 53, init => 0};
asset_en(<<"social"/utf8>>) -> #{id => 54, init => 0};
asset_en(_) -> undefined.


food(10000) -> #{id => 10000, name => <<"N级元初米饭"/utf8>>, desc => <<"米饭"/utf8>>, rare => <<"N"/utf8>>, type => 1, gain => [{51, 10}], loss => [{1, 10}]};
food(_) -> undefined.


play(1) -> #{id => 1, name => <<"旅行"/utf8>>, icon => <<"11001"/utf8>>, desc => <<"爽歪歪"/utf8>>, rare => <<"S"/utf8>>, type => 1, tick => [{1, 100}], gain => [{51, 10},{52, 5},{54, 5}], loss => [{21, 100}], calc_time => 5, continue_time => 60};
play(2) -> #{id => 2, name => <<"睡觉"/utf8>>, icon => <<"11002"/utf8>>, desc => <<"梦里"/utf8>>, rare => <<"S"/utf8>>, type => 2, tick => [], gain => [{21, 2}], loss => [], calc_time => 5, continue_time => 60};
play(_) -> undefined.


