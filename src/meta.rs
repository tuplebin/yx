use std::collections::HashMap;


pub struct Fun {
    pub sheet: String,
    pub lang: String,
    pub fun: String,
    pub keys: String,
    pub symbol: String,
    pub values: String,
    pub def_v: String,
}

pub struct Sheet {
    // 字段
    pub field: Vec<String>,
    // 类型
    pub types: Vec<String>,
    // 数据
    pub data: Vec<Vec<String>>,
    // 通过键找位置
    pub key_pos: HashMap<String, usize>,
}

pub fn fun_key(key_pos: &Vec<&usize>, maps: &Vec<String>) -> Option<String>{
    let mut key_str = String::new();
    let first = maps.get(*key_pos[0]).unwrap();
    
    if !first.is_empty() {
        if key_pos.len() > 1 {
            key_str.push_str("{");
            key_str.push_str(first);
            for i in 1..key_pos.len() {
                let next = maps.get(*key_pos[i]).unwrap();
                if !next.is_empty() && next.ne("\"\""){
                    key_str.push_str(", ");
                    key_str.push_str(next);
                }else {
                    return None
                }
            }
            key_str.push_str("}");
        }else {
            key_str.push_str(first);
        }
        Some(key_str)
    }else {
        None
    }
}
