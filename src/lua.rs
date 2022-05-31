use std::{collections::HashMap, fs::{ File, OpenOptions}, io::Write};

use crate::meta::{Fun, Sheet, self};

pub fn handle(fname: &str, funs: &Vec<Fun>, sheet_map: &HashMap<String, Sheet>) {
    let file = fname.to_string() + ".lua";
    let fname = fname.split('_').map(|s| format!("{}{}", (&s[..1].to_string()).to_uppercase(), &s[1..])).collect::<String>();


    let mut buffer = OpenOptions::new().write(true).create(true).truncate(true).open(file).unwrap();
    buffer.write_fmt(format_args!("Config = Config or {{}} \nConfig.{} = Config.{} or {{}}\n\n\n",fname, fname)).unwrap();

    let lua: Vec<&Fun> = funs.iter().filter(|f| f.lang.contains("lua")).collect();

    for f in lua {
        let s = sheet_map.get(f.sheet.as_str()).unwrap();
        write_lua(&mut buffer, &fname, f, s)
    }
}


fn write_lua(buffer: &mut File, fname: &String, f: &Fun, s: &Sheet) {
    let keys_vec = f.keys.split(|x| x ==',' || x == '，').collect::<Vec<&str>>();
    let value_vec = f.values.split(|x| x ==',' || x == '，').collect::<Vec<&str>>();


    let mut key_pos = Vec::new();
    for k in keys_vec {
        key_pos.push(s.key_pos.get(&k.to_string()).unwrap());
    }

    let mut value_pos = Vec::new();
    for k in value_vec {
        match k {
            "$all" => s.key_pos.values().for_each(|x| value_pos.push(x)),
            _ => value_pos.push(s.key_pos.get(&k.to_string()).unwrap()),
        }
        
    }
    value_pos.sort();

    buffer.write_fmt(format_args!("Config.{}.{} = {{\n", fname, f.fun)).unwrap();

    let mut all_key = Vec::new();
    for data in &s.data {
        if let Some(master_key) = meta::fun_key(&key_pos, &data) {
            let values = fun_lua_value(&value_pos, s, &data);
            buffer.write_fmt(format_args!("\t[{}] = {},\n", master_key, values)).unwrap();
            all_key.push(master_key);
        }
    }
    buffer.write_fmt(format_args!("}}\nConfig.{}.{}_len = {}\n", fname, f.fun, all_key.len())).unwrap();
    buffer.write_fmt(format_args!("Config.{}.{}_keys = {{{}}}\n", fname, f.fun, all_key.join(", "))).unwrap();
    buffer.write_fmt(format_args!("Config.{}.{}_fun = function(key)\n", fname, f.fun)).unwrap();
    match f.symbol.as_str() {
        "=" => buffer.write_fmt(format_args!("\treturn Config.{}.{}[key]\nend\n\n", fname, f.fun)).unwrap(),
        _ => {
            buffer.write_fmt(format_args!("\tfor _, v in pairs(Config.{}.{}_keys) do\n", fname, f.fun)).unwrap();
            buffer.write_fmt(format_args!("\t\tif key {} v then\n\t\t\treturn Config.{}.{}[v]\n\t\tend\n\tend\n\treturn {}\nend\n", f.symbol, fname, f.fun, f.def_v)).unwrap();
        }
            
    }
}



fn fun_lua_value(value_pos: &Vec<&usize>, s: &Sheet, row: &Vec<String>) -> String{
    let mut value_str = String::new();
    let first = row.get(*value_pos[0]).unwrap();
    
    if value_pos.len() > 1 {
        value_str.push_str("{");
        value_str.push_str(s.field.get(*value_pos[0]).unwrap());
        value_str.push_str(" = ");
        value_str.push_str(lua_value(s, row, 0).as_str());
        for i in 1..value_pos.len() {
            value_str.push_str(", ");
            value_str.push_str(s.field.get(*value_pos[i]).unwrap());
            value_str.push_str(" = ");
            value_str.push_str(lua_value(s, row, i).as_str());
        }
        value_str.push_str("}");
    }else{
        value_str.push_str(first);
    }
    
    value_str
}

fn lua_value(sheet: &Sheet, row: &Vec<String>, index: usize) -> String {
    let cell = row.get(index).unwrap();
    if cell.is_empty() || cell.eq("\"\"") {
        let d = match sheet.types[index].as_str() {
            "num" => "0",
            "term" => "{}",
            _ => "''",
        };
        d.to_string()
    }else{
        match sheet.types[index].as_str()  {
            "term" => format!("{{{}}}", cell),
            "str" => format!("{}", cell),
            _ => cell.to_string(),
        }
    }
}