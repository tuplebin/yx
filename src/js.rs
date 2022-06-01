use std::{collections::HashMap, fs::{ File, OpenOptions}, io::Write};

use crate::meta::{Fun, Sheet, self};

pub fn handle(fname: &str, funs: &Vec<Fun>, sheet_map: &HashMap<String, Sheet>) {
    let file = fname.to_string() + ".json";
    let mut buffer = OpenOptions::new().write(true).create(true).truncate(true).open(file).unwrap();
    let f_list = fname.split(|x| x =='/').collect::<Vec<&str>>();
    buffer.write_fmt(format_args!("{{\n")).unwrap();

    let js: Vec<&Fun> = funs.iter().filter(|f| f.lang.contains("js")).collect();

    let len = js.len();
    let pre = f_list.last().unwrap();
    for idx in 0..len {
        let f = js.get(idx).unwrap();
        let s = sheet_map.get(f.sheet.as_str()).unwrap();
        write_json(&mut buffer, f, s, *pre, idx == len-1)
    }
    buffer.write_fmt(format_args!("}}\n")).unwrap();
}


// tpl(xx) -> ad;
fn write_json(buffer: &mut File, f: &Fun, s: &Sheet, pre: &str, is_last: bool) {
    buffer.write_fmt(format_args!("\t\"{}_{}\": {{\n",  pre, f.fun)).unwrap();

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

    // 写第一行
    let data = s.data.get(0).unwrap();
    let args = meta::fun_key(&key_pos, &data);
    if args.is_some() {
        let k = args.unwrap();
        if k.ne("\"\"") {
            let values = fun_value(&value_pos, s, &data);
            if s.types[*key_pos[0]].eq("str") {
                buffer.write_fmt(format_args!("\t\t{}: {}",  k, values)).unwrap();
            } else {
                buffer.write_fmt(format_args!("\t\t\"{}\": {}",  k, values)).unwrap();
            }
        }
    }

    let len = s.data.len();
    for idx in 1..len {
        let data = s.data.get(idx).unwrap();
        let args = meta::fun_key(&key_pos, &data);
        if args.is_some() {
            let k = args.unwrap();
            if k.ne("\"\"") {
                let values = fun_value(&value_pos, s, &data);
                if s.types[*key_pos[0]].eq("str") {
                    buffer.write_fmt(format_args!(",\n\t\t{}: {}", k, values)).unwrap();
                } else {
                    buffer.write_fmt(format_args!(",\n\t\t\"{}\": {}", k, values)).unwrap();
                }
            }
            
            
            
        }
    }

    if is_last {
        buffer.write_fmt(format_args!("\n\t}}\n")).unwrap();
    } else {
        buffer.write_fmt(format_args!("\n\t}},\n")).unwrap();
    }
    
}



fn fun_value(value_pos: &Vec<&usize>, s: &Sheet, row: &Vec<String>) -> String{
    let mut value_str = String::new();
    let first = row.get(*value_pos[0]).unwrap();
    
    if value_pos.len() > 1 {
        value_str.push_str("{ \"");
        value_str.push_str(s.field.get(*value_pos[0]).unwrap());
        value_str.push_str("\": ");
        value_str.push_str(erl_value(s, row, 0).as_str());
        for i in 1..value_pos.len() {
            value_str.push_str(", \"");
            value_str.push_str(s.field.get(*value_pos[i]).unwrap());
            value_str.push_str("\": ");
            value_str.push_str(erl_value(s, row, *value_pos[i]).as_str());
        }
        value_str.push_str("}");
    }else{
        value_str.push_str(first);
    }
    
    value_str
}

fn erl_value(sheet: &Sheet, row: &Vec<String>, index: usize) -> String {
    let cell = row.get(index).unwrap();
    
    if cell.is_empty() || cell.eq("\"\"") {
        let d = match sheet.types[index].as_str() {
            "num" => "0",
            "term" => "[]",
            _ => "\"\"",
        };
        // println!("cell:{:?}", cell);
        d.to_string()
    }else{
        match sheet.types[index].as_str()  {
            "term" => format!("[{}]", cell.replace("{", "[").replace("}", "]")),
            "str" => format!("{}", cell),
            _ => cell.to_string(),
        }
    }
}