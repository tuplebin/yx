use std::{collections::HashMap, env};

use calamine::{open_workbook, DataType, Range, Reader, Xlsx};
use chrono::NaiveDateTime;
use meta::{Fun, Sheet};

pub mod erl;
pub mod js;
pub mod meta;

fn main() {
    let name = if let Some(file) = env::args().nth(1) {
        file
    } else {
        println!("无xlsx文件参数");
        return;
    };
    // let s_name = String::from(name);
    let file_name = name.split('.').collect::<Vec<&str>>();
    let mut excel: Xlsx<_> = open_workbook(&name).unwrap();

    // 存放所有的函数列表
    let mut funs: Vec<Fun> = Vec::new();
    // 存放所有字段数据
    let mut sheet_map: HashMap<String, Sheet> = HashMap::new();
    // 存放所有需要的sheet名称
    let mut sheets: Vec<String> = Vec::new();

    // 获取所有需要导出的函数列表
    if let Some(Ok(r)) = excel.worksheet_range("config") {
        handle_funs(r, &mut funs, &mut sheets);
    }

    // 循环所有的表页
    for sn in sheets {
        if let Some(Ok(r)) = excel.worksheet_range(&sn) {
            handle_data(r, sn, &mut sheet_map);
        }
    }

    let fname = file_name[0];
    erl::handle(fname, &funs, &sheet_map);
    // lua::handle(fname, &funs, &sheet_map);
    js::handle(fname, &funs, &sheet_map);
}

// 获取所有的函数
fn handle_funs(r: Range<DataType>, funs: &mut Vec<Fun>, sheets: &mut Vec<String>) {
    let header = r.rows().nth(0).unwrap();
    let mut map: HashMap<String, usize> = HashMap::new();
    for i in 0..header.len() {
        map.insert(header.get(i).unwrap().to_string(), i);
    }

    for row in r.rows().skip(1) {
        let sheet_name = row[*map.get("sheet").unwrap()].to_string();

        let f = Fun {
            sheet: sheet_name.to_string(),
            lang: row[*map.get("lang").unwrap()].to_string(),
            fun: row[*map.get("fun").unwrap()].to_string(),
            keys: row[*map.get("keys").unwrap()].to_string(),
            symbol: row[*map.get("symbol").unwrap()].to_string(),
            values: row[*map.get("values").unwrap()].to_string(),
            def_v: row[*map.get("default").unwrap()].to_string(),
        };

        funs.push(f);

        if !sheets.contains(&sheet_name.to_string()) {
            sheets.push(sheet_name);
        }
    }
}

// 获取所有的表数据
fn handle_data(r: Range<DataType>, sn: String, sheet_map: &mut HashMap<String, Sheet>) {
    let mut sheet_vec = Vec::new();
    let header_keys = r.rows().nth(1).unwrap();
    let header_types = r.rows().nth(2).unwrap();
    let mut key_map: HashMap<String, usize> = HashMap::new();
    // 字段
    let mut field_vec = Vec::new();
    // 类型
    let mut type_vec = Vec::new();
    for i in 0..header_keys.len() {
        let k_str = header_keys.get(i).unwrap().to_string();
        if !k_str.is_empty() {
            key_map.insert(k_str.to_string(), i);
            field_vec.push(k_str);
            type_vec.push(header_types.get(i).unwrap().to_string());
        } else {
            break;
        }
    }

    for row in r.rows().skip(3) {
        let mut row_data = Vec::new();
        for i in 0..header_keys.len() {
            if let DataType::String(str) = header_types.get(i).unwrap() {
                match str.as_str() {
                    "str" => {
                        let mut s = row[i].to_string();
                        s.insert_str(0, "\"");
                        s.push_str("\"");
                        row_data.push(s);
                    },
                    "time" => {
                        let t = row[i].to_string();
                        let no_timezone = NaiveDateTime::parse_from_str(&t, "\"%Y-%m-%d %H:%M:%S\"").unwrap();
                        let timestamp = no_timezone.timestamp() - 28800;
                        row_data.push(timestamp.to_string());
                    },
                    _ => {
                        row_data.push(row[i].to_string());
                    }
                }
            } else {
                row_data.push(row[i].to_string());
            }
        }
        sheet_vec.push(row_data);
    }
    let s = Sheet {
        field: field_vec,
        types: type_vec,
        data: sheet_vec,
        key_pos: key_map,
    };
    sheet_map.insert(sn, s);
}
