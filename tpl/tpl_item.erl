-module(tpl_item).
-export([
	asset/1
	,asset_keys/0
	,asset_id/1
	,asset_id_keys/0
	,asset_en/1
	,asset_en_keys/0
	,base/1
	,base_keys/0
	,play/1
	,play_keys/0
	,rand_class/1
	,rand_class_keys/0
	,rand_group/1
	,rand_group_keys/0
	,rand_item/1
	,rand_item_keys/0
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
asset(61) -> #{id => 61, name => <<"攻击"/utf8>>, field => <<"attack"/utf8>>, init => 0, effect => [], type => <<>>};
asset(62) -> #{id => 62, name => <<"防御"/utf8>>, field => <<"defense"/utf8>>, init => 0, effect => [], type => <<>>};
asset(63) -> #{id => 63, name => <<"血量"/utf8>>, field => <<"hp"/utf8>>, init => 0, effect => [], type => <<>>};
asset(64) -> #{id => 64, name => <<"速度"/utf8>>, field => <<"speed"/utf8>>, init => 0, effect => [], type => <<>>};
asset(65) -> #{id => 65, name => <<"暴击"/utf8>>, field => <<"crit"/utf8>>, init => 0, effect => [], type => <<>>};
asset(_) -> undefined.


asset_keys() -> [1,2,21,22,31,32,33,34,35,51,52,53,54,61,62,63,64,65].


asset_id(1) -> <<"crystal"/utf8>>;
asset_id(2) -> <<"card"/utf8>>;
asset_id(21) -> <<"physical"/utf8>>;
asset_id(22) -> <<"satiety"/utf8>>;
asset_id(31) -> <<"intellect"/utf8>>;
asset_id(32) -> <<"endurance"/utf8>>;
asset_id(33) -> <<"perception"/utf8>>;
asset_id(34) -> <<"charm"/utf8>>;
asset_id(35) -> <<"luck"/utf8>>;
asset_id(51) -> <<"comfort"/utf8>>;
asset_id(52) -> <<"happy"/utf8>>;
asset_id(53) -> <<"health"/utf8>>;
asset_id(54) -> <<"social"/utf8>>;
asset_id(61) -> <<"attack"/utf8>>;
asset_id(62) -> <<"defense"/utf8>>;
asset_id(63) -> <<"hp"/utf8>>;
asset_id(64) -> <<"speed"/utf8>>;
asset_id(65) -> <<"crit"/utf8>>;
asset_id(_) -> undefined.


asset_id_keys() -> [1,2,21,22,31,32,33,34,35,51,52,53,54,61,62,63,64,65].


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
asset_en(<<"attack"/utf8>>) -> #{id => 61, init => 0};
asset_en(<<"defense"/utf8>>) -> #{id => 62, init => 0};
asset_en(<<"hp"/utf8>>) -> #{id => 63, init => 0};
asset_en(<<"speed"/utf8>>) -> #{id => 64, init => 0};
asset_en(<<"crit"/utf8>>) -> #{id => 65, init => 0};
asset_en(_) -> undefined.


asset_en_keys() -> [<<"crystal"/utf8>>,<<"card"/utf8>>,<<"physical"/utf8>>,<<"satiety"/utf8>>,<<"intellect"/utf8>>,<<"endurance"/utf8>>,<<"perception"/utf8>>,<<"charm"/utf8>>,<<"luck"/utf8>>,<<"comfort"/utf8>>,<<"happy"/utf8>>,<<"health"/utf8>>,<<"social"/utf8>>,<<"attack"/utf8>>,<<"defense"/utf8>>,<<"hp"/utf8>>,<<"speed"/utf8>>,<<"crit"/utf8>>].


base(10000) -> #{id => 10000, name => <<"N级元初米饭"/utf8>>, icon => <<"1001"/utf8>>, card => <<"1001"/utf8>>, desc => <<"米饭"/utf8>>, rare => <<"N"/utf8>>, type => 10, sub_type => 0, store_type => 1, use => 1, stack => 99, init_attr => [], extra => [], gain => [{51, 10}], loss => [{1, 10}]};
base(19001) -> #{id => 19001, name => <<"R级兑换券"/utf8>>, icon => <<"19001"/utf8>>, card => <<"19001"/utf8>>, desc => <<"兑换券"/utf8>>, rare => <<"R"/utf8>>, type => 19, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(19002) -> #{id => 19002, name => <<"SR级兑换券"/utf8>>, icon => <<"19002"/utf8>>, card => <<"19002"/utf8>>, desc => <<"兑换券"/utf8>>, rare => <<"R"/utf8>>, type => 19, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(19003) -> #{id => 19003, name => <<"SSR级兑换券"/utf8>>, icon => <<"19003"/utf8>>, card => <<"19003"/utf8>>, desc => <<"兑换券"/utf8>>, rare => <<"SR"/utf8>>, type => 19, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(19004) -> #{id => 19004, name => <<"UR级兑换券"/utf8>>, icon => <<"19004"/utf8>>, card => <<"19004"/utf8>>, desc => <<"兑换券"/utf8>>, rare => <<"SSR"/utf8>>, type => 19, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(20001) -> #{id => 20001, name => <<"木质盲盒"/utf8>>, icon => <<"20001"/utf8>>, card => <<"20001"/utf8>>, desc => <<"破破烂烂的木质盲盒"/utf8>>, rare => <<"N"/utf8>>, type => 20, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(20002) -> #{id => 20002, name => <<"铁质盲盒"/utf8>>, icon => <<"20002"/utf8>>, card => <<"20002"/utf8>>, desc => <<"盲盒"/utf8>>, rare => <<"R"/utf8>>, type => 20, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(20003) -> #{id => 20003, name => <<"青铜盲盒"/utf8>>, icon => <<"20003"/utf8>>, card => <<"20003"/utf8>>, desc => <<"盲盒"/utf8>>, rare => <<"SR"/utf8>>, type => 20, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(20004) -> #{id => 20004, name => <<"黄金盲盒"/utf8>>, icon => <<"20004"/utf8>>, card => <<"20004"/utf8>>, desc => <<"盲盒"/utf8>>, rare => <<"SSR"/utf8>>, type => 20, sub_type => 0, store_type => 2, use => 0, stack => 1, init_attr => [], extra => [], gain => [], loss => []};
base(30001) -> #{id => 30001, name => <<"头"/utf8>>, icon => <<"30001"/utf8>>, card => <<"30001"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 1, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62], [1, 100]}, {[63,64,65], [1, 1000]}], extra => [10001,10002], gain => [], loss => []};
base(30002) -> #{id => 30002, name => <<"躯干"/utf8>>, icon => <<"30002"/utf8>>, card => <<"30002"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 2, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62], [1, 100]}, {[63,64,65], [1, 1001]}], extra => [10001,10003], gain => [], loss => []};
base(30003) -> #{id => 30003, name => <<"左手"/utf8>>, icon => <<"30005"/utf8>>, card => <<"30005"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 3, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62], [1, 100]}, {[63,64,65], [1, 1002]}], extra => [10001,10004], gain => [], loss => []};
base(30004) -> #{id => 30004, name => <<"右手"/utf8>>, icon => <<"30006"/utf8>>, card => <<"30006"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 4, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62], [1, 100]}, {[63,64,65], [1, 1003]}], extra => [10001,10005], gain => [], loss => []};
base(30005) -> #{id => 30005, name => <<"左脚"/utf8>>, icon => <<"30009"/utf8>>, card => <<"30009"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 5, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62], [1, 100]}, {[63,64,65], [1, 1004]}], extra => [10001,10006], gain => [], loss => []};
base(30006) -> #{id => 30006, name => <<"右脚"/utf8>>, icon => <<"30010"/utf8>>, card => <<"30010"/utf8>>, desc => <<>>, rare => <<"SR"/utf8>>, type => 30, sub_type => 6, store_type => 2, use => 0, stack => 1, init_attr => [{61, [100, 100]}, {[62,63,64], [1, 100]}, {[62,63,64,65], [1, 1005]}], extra => [10001,10007], gain => [], loss => []};
base(_) -> undefined.


base_keys() -> [10000,19001,19002,19003,19004,20001,20002,20003,20004,30001,30002,30003,30004,30005,30006].


play(1) -> #{id => 1, name => <<"旅行"/utf8>>, icon => <<"11001"/utf8>>, desc => <<"爽歪歪"/utf8>>, rare => <<"S"/utf8>>, type => 1, ticket => [{1, 100}], gain => [{51, 10},{52, 2},{54, 5}], loss => [{21, 10}], calc_time => 1, continue_time => 60};
play(2) -> #{id => 2, name => <<"睡觉"/utf8>>, icon => <<"11002"/utf8>>, desc => <<"梦里"/utf8>>, rare => <<"S"/utf8>>, type => 2, ticket => [], gain => [{21, 2}], loss => [], calc_time => 5, continue_time => 60};
play(_) -> undefined.


play_keys() -> [1,2].


rand_class(1) -> [{1, 10}, {2, 10}, {3, 5}];
rand_class(_) -> [].


rand_class_keys() -> [1].


rand_group(1) -> [{1, 1},{2, 1}];
rand_group(2) -> [{3, 1},{4,1}];
rand_group(3) -> [{5,1},{6,1}];
rand_group(4) -> [{1,2}];
rand_group(5) -> [];
rand_group(_) -> [].


rand_group_keys() -> [1,2,3,4,5].


rand_item(1) -> [{30001, 5},{30002, 5}];
rand_item(2) -> [{30003, 5}];
rand_item(3) -> [{30004, 5},{30001, 5}];
rand_item(4) -> [{30005, 5},{30002, 5}];
rand_item(5) -> [{30006, 5},{30003, 5}];
rand_item(6) -> [{30007, 5},{30004, 5}];
rand_item(_) -> [].


rand_item_keys() -> [1,2,3,4,5,6].


