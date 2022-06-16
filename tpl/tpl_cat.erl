-module(tpl_cat).
-export([
	rand/1
	,rand_keys/0
	,combin/1
	,combin_keys/0
	,smelt/1
	,smelt_keys/0
	,rare_score/1
	,rare_score_keys/0
	,pos/1
	,pos_keys/0
	,talent/1
	,talent_keys/0
	,pre_name/1
	,pre_name_keys/0
	,name/1
	,name_keys/0
	,score_rare/1
	,score_rare_keys/0
	,advance/1
	,advance_keys/0
]).


rand(20001) -> 1;
rand(20002) -> 2;
rand(20003) -> 3;
rand(20004) -> 4;
rand(_) -> undefined.


rand_keys() -> [20001,20002,20003,20004].


combin(20002) -> #{id => 20002, loss_num => 10, loss_other => [{19001, 1}], gain => [{20003, 1}], rand_list => [31]};
combin(_) -> undefined.


combin_keys() -> [20002].


smelt(<<"rare"/utf8>>) -> 1;
smelt(<<"num"/utf8>>) -> 3;
smelt(<<"N"/utf8>>) -> 20001;
smelt(<<"R"/utf8>>) -> 20002;
smelt(<<"SR"/utf8>>) -> 20003;
smelt(<<"SSR"/utf8>>) -> 20004;
smelt(_) -> undefined.


smelt_keys() -> [<<"rare"/utf8>>,<<"num"/utf8>>,<<"N"/utf8>>,<<"R"/utf8>>,<<"SR"/utf8>>,<<"SSR"/utf8>>].


rare_score(<<"N"/utf8>>) -> 10;
rare_score(<<"R"/utf8>>) -> 20;
rare_score(<<"SR"/utf8>>) -> 30;
rare_score(<<"SSR"/utf8>>) -> 40;
rare_score(<<"UR"/utf8>>) -> 50;
rare_score(_) -> 0.


rare_score_keys() -> [<<"N"/utf8>>,<<"R"/utf8>>,<<"SR"/utf8>>,<<"SSR"/utf8>>,<<"UR"/utf8>>].


pos(1) -> #{pos => 1, name => <<"头"/utf8>>, name_key => <<"head"/utf8>>};
pos(2) -> #{pos => 2, name => <<"躯干"/utf8>>, name_key => <<"body"/utf8>>};
pos(3) -> #{pos => 3, name => <<"左手"/utf8>>, name_key => <<"leftHand"/utf8>>};
pos(4) -> #{pos => 4, name => <<"右手"/utf8>>, name_key => <<"rightHand"/utf8>>};
pos(5) -> #{pos => 5, name => <<"左脚"/utf8>>, name_key => <<"leftFoot"/utf8>>};
pos(6) -> #{pos => 6, name => <<"右脚"/utf8>>, name_key => <<"rightFoot"/utf8>>};
pos(_) -> undefined.


pos_keys() -> [1,2,3,4,5,6].


talent(10001) -> #{id => 10001, name => <<"反击"/utf8>>, commit => <<"受击时有20%几率自动反击，伤害降低50%，被反击技能攻击的目标不能发动反击"/utf8>>, skill_effect => [{fight_back, 20, 50}], sort => 1, atk_type => 0};
talent(10002) -> #{id => 10002, name => <<"抵御"/utf8>>, commit => <<"受到反击后，防御增加10%"/utf8>>, skill_effect => [{anti_fight_back,  [{def, 10}]}], sort => 2, atk_type => 0};
talent(10003) -> #{id => 10003, name => <<"连击"/utf8>>, commit => <<"每次攻击时，有50%几率增加1次攻击，触发时攻击伤害降低25%。"/utf8>>, skill_effect => [{double_hit, 50,  -25}], sort => 3, atk_type => 1};
talent(10004) -> #{id => 10004, name => <<"反震"/utf8>>, commit => <<"受击时有20%几率将受到伤害的30%反馈给攻击目标，并免疫连击技能。"/utf8>>, skill_effect => [{anti_double_hit,  20, 30}], sort => 4, atk_type => 0};
talent(10005) -> #{id => 10005, name => <<"幸运"/utf8>>, commit => <<"受击时，有30%几率，免受所有暴击几率带来的暴击伤害"/utf8>>, skill_effect => [{anti_crit, 30}], sort => 5, atk_type => 0};
talent(10006) -> #{id => 10006, name => <<"必杀"/utf8>>, commit => <<"增加暴击几率20%，增加暴击伤害25%"/utf8>>, skill_effect => [{crit, 20, 25}], sort => 6, atk_type => 0};
talent(10007) -> #{id => 10007, name => <<"嗜血"/utf8>>, commit => <<"每次攻击后，自身恢复对方受击血量的15%"/utf8>>, skill_effect => [{hurt_cure, 15}], sort => 7, atk_type => 1};
talent(10008) -> #{id => 10008, name => <<"偷袭"/utf8>>, commit => <<"血量低于20%，免受嗜血技能效果。"/utf8>>, skill_effect => [{anti_hurt_cure,  20}], sort => 8, atk_type => 0};
talent(10009) -> #{id => 10009, name => <<"强击"/utf8>>, commit => <<"增加自身攻击属性25%"/utf8>>, skill_effect => [{atk,  25}], sort => 9, atk_type => 0};
talent(10010) -> #{id => 10010, name => <<"肉盾"/utf8>>, commit => <<"提升自身30%防御属性"/utf8>>, skill_effect => [{def,  25}], sort => 10, atk_type => 0};
talent(_) -> undefined.


talent_keys() -> [10001,10002,10003,10004,10005,10006,10007,10008,10009,10010].


pre_name(<<"N"/utf8>>) -> <<"平凡的"/utf8>>;
pre_name(<<"R"/utf8>>) -> <<"特殊的"/utf8>>;
pre_name(<<"SR"/utf8>>) -> <<"优异的"/utf8>>;
pre_name(<<"SSR"/utf8>>) -> <<"卓越的"/utf8>>;
pre_name(<<"UR"/utf8>>) -> <<"传奇的"/utf8>>;
pre_name(_) -> undefined.


pre_name_keys() -> [<<"N"/utf8>>,<<"R"/utf8>>,<<"SR"/utf8>>,<<"SSR"/utf8>>,<<"UR"/utf8>>].


name(30001) -> <<"战士"/utf8>>;
name(10002) -> <<"尼莫"/utf8>>;
name(_) -> undefined.


name_keys() -> [30001,10002].


score_rare(T) when T < 20 -> <<"N"/utf8>>;
score_rare(T) when T < 30 -> <<"R"/utf8>>;
score_rare(T) when T < 40 -> <<"SR"/utf8>>;
score_rare(T) when T < 50 -> <<"SSR"/utf8>>;
score_rare(T) when T < 60 -> <<"UR"/utf8>>;
score_rare(_) -> undefined.


score_rare_keys() -> [20,30,40,50,60].


advance(1) -> #{level => 1, crystal => 1, crystalRate => 100, card => 1, cardRate => 100};
advance(2) -> #{level => 2, crystal => 2, crystalRate => 90, card => 2, cardRate => 100};
advance(3) -> #{level => 3, crystal => 3, crystalRate => 80, card => 3, cardRate => 100};
advance(4) -> #{level => 4, crystal => 4, crystalRate => 70, card => 4, cardRate => 100};
advance(5) -> #{level => 5, crystal => 5, crystalRate => 60, card => 5, cardRate => 100};
advance(6) -> #{level => 6, crystal => 6, crystalRate => 50, card => 6, cardRate => 100};
advance(7) -> #{level => 7, crystal => 7, crystalRate => 40, card => 7, cardRate => 80};
advance(8) -> #{level => 8, crystal => 8, crystalRate => 30, card => 8, cardRate => 60};
advance(9) -> #{level => 9, crystal => 9, crystalRate => 20, card => 9, cardRate => 40};
advance(10) -> #{level => 10, crystal => 10, crystalRate => 10, card => 10, cardRate => 20};
advance(_) -> undefined.


advance_keys() -> [1,2,3,4,5,6,7,8,9,10].


