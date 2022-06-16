-module(tpl_work).
-export([
	info/1
	,info_keys/0
]).


info(1) -> #{id => 1, com_name => <<"元初"/utf8>>, com_logo => 1000, work_name => <<"设计"/utf8>>, public_time => 1653376755, start_time => 1653376756, end_time => 1656055157, recruit_num => 100, require => [{21, 100},{22,100}], consume => [{1, 100}], income => [{2,100}], calc_time => 60};
info(2) -> #{id => 2, com_name => <<"元初"/utf8>>, com_logo => 1000, work_name => <<"产品"/utf8>>, public_time => 1653376756, start_time => 1653376757, end_time => 1656055158, recruit_num => 1000, require => [{21, 100},{22,100}], consume => [{1, 101}], income => [{1,101},{2,300}], calc_time => 60};
info(3) -> #{id => 3, com_name => <<"元初"/utf8>>, com_logo => 1000, work_name => <<"商务"/utf8>>, public_time => 1653376757, start_time => 1653376758, end_time => 1656055159, recruit_num => 200, require => [{21, 100},{22,100}], consume => [{1, 102}], income => [{2,102}], calc_time => 60};
info(4) -> #{id => 4, com_name => <<"元初"/utf8>>, com_logo => 1000, work_name => <<"运营"/utf8>>, public_time => 1653376758, start_time => 1653376759, end_time => 1656055160, recruit_num => 500, require => [{21, 100},{22,100}], consume => [{1, 103}], income => [{2,103}], calc_time => 60};
info(_) -> undefined.


info_keys() -> [1,2,3,4].


