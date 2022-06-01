use std::{
    collections::HashMap,
    fs::{File, OpenOptions},
    io::Write,
};

use crate::meta::{self, Fun, Sheet};

pub fn handle(fname: &str, funs: &Vec<Fun>, sheet_map: &HashMap<String, Sheet>) {
    let file = fname.to_string() + ".erl";
    let mut buffer = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(file)
        .unwrap();
    let f_list = fname.split(|x| x == '/').collect::<Vec<&str>>();
    buffer
        .write_fmt(format_args!(
            "-module({}).\n-export([\n",
            f_list.last().unwrap().to_string()
        ))
        .unwrap();

    let erl: Vec<&Fun> = funs.iter().filter(|f| f.lang.contains("erl")).collect();
    match erl.len() {
        0 => (),
        1 => buffer
            .write_fmt(format_args!("\t{}/1\n", erl[0].fun))
            .unwrap(),
        _ => {
            buffer
                .write_fmt(format_args!("\t{}/1\n", erl[0].fun))
                .unwrap();
            for i in 1..erl.len() {
                buffer
                    .write_fmt(format_args!("\t,{}/1\n", erl[i].fun))
                    .unwrap();
            }
        }
    }

    buffer.write(b"]).\n\n\n").unwrap();

    for f in erl {
        let s = sheet_map.get(f.sheet.as_str()).unwrap();
        write_erl(&mut buffer, f, s)
    }
}

// tpl(xx) -> ad;
fn write_erl(buffer: &mut File, f: &Fun, s: &Sheet) {
    let keys_vec = f
        .keys
        .split(|x| x == ',' || x == '，')
        .collect::<Vec<&str>>();
    let value_vec = f
        .values
        .split(|x| x == ',' || x == '，')
        .collect::<Vec<&str>>();

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

    for data in &s.data {
        let args = meta::fun_key(&key_pos, &data);
        if args.is_some() {
            let mut k = args.unwrap();
            if k.ne("\"\"") {
                if s.types[*key_pos[0]].eq("str") {
                    k = format!("<<{}/utf8>>", k);
                }
                let values = fun_value(&value_pos, s, &data);
                match f.symbol.as_str() {
                    "=" => buffer
                        .write_fmt(format_args!(
                            "{}({}) -> {};\n",
                            f.fun,
                            k,
                            values
                        ))
                        .unwrap(),
                    _ => buffer
                        .write_fmt(format_args!(
                            "{}(T) when T {} {} -> {};\n",
                            f.fun,
                            f.symbol,
                            k,
                            values
                        ))
                        .unwrap(),
                }
            }
        }
    }

    buffer
        .write_fmt(format_args!("{}(_) -> {}.\n\n\n", f.fun, f.def_v))
        .unwrap();
}

fn fun_value(value_pos: &Vec<&usize>, s: &Sheet, row: &Vec<String>) -> String {
    let mut value_str = String::new();
    let first = row.get(*value_pos[0]).unwrap();

    if value_pos.len() > 1 {
        value_str.push_str("#{");
        value_str.push_str(s.field.get(*value_pos[0]).unwrap());
        value_str.push_str(" => ");
        value_str.push_str(erl_value(s, row, 0).as_str());
        for i in 1..value_pos.len() {
            value_str.push_str(", ");
            value_str.push_str(s.field.get(*value_pos[i]).unwrap());
            value_str.push_str(" => ");
            value_str.push_str(erl_value(s, row, *value_pos[i]).as_str());
        }
        value_str.push_str("}");
    } else {
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
            _ => "<<>>",
        };
        d.to_string()
    } else {
        match sheet.types[index].as_str() {
            "term" => format!("[{}]", cell),
            "str" => format!("<<{}/utf8>>", cell),
            _ => cell.to_string(),
        }
    }
}
