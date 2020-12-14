#![deny(unused_must_use)]

use clap::*;
use serde::{Deserialize, Serialize};
use anyhow::Result;
use std::str::FromStr;
use chrono::{DateTime, Duration, Local, NaiveDateTime, NaiveDate};
use std::process::{Command, Stdio};
use std::collections::HashMap;
use csv::{Reader, ReaderBuilder};
use std::fs::File;
use std::io::Write;

#[derive(Clap, Debug)]
#[clap(author = "Stock84")]
struct Args {
    /// Path to data file.
    #[clap(long, short)]
    path: String,
    #[clap(long, short)]
    ytd: bool,
    #[clap(long, short)]
    mtd: bool,
    #[clap(long, short)]
    wtd: bool,
    #[clap(long, short)]
    start_date: Option<String>,
    #[clap(long, short)]
    end_date: Option<String>,
}

#[derive(Debug, Deserialize, Serialize)]
struct Entry {
    #[serde(rename = "start date")]
    start_date: String,
    #[serde(rename = "total seconds")]
    total_seconds: f32,
    #[serde(rename = "total minutes")]
    total_minutes: f32,
    #[serde(rename = "total hours")]
    total_hours: f32,
}

fn show(entries: &HashMap<NaiveDate, f32>, duration: Duration) -> Result<()> {
    let total: f32 = entries.values().sum();
    let avg = total / duration.num_days() as f32;
    let cmd = Command::new("feedgnuplot")
        .arg("--terminal")
        .arg("x11")
        .arg("--with")
        .arg("boxes")
        .arg("--set")
        .arg("boxwidth 82800")
        .arg("--set")
        .arg("style fill solid")
        .arg("--domain")
        .arg("--lines")
        .arg("--title")
        .arg(format!("Total hours: {:.2}, avg: {:.2}", total, avg))
        .arg("--timefmt")
        .arg("%Y-%m-%d-%H:%M:%S")
        .stdin(Stdio::piped())
        .spawn()?;
    let mut stdin = cmd.stdin.unwrap();
    let mut vec: Vec<_> = entries.iter().collect();
    vec.sort_by_key(|x| x.0);
    for (date, hours) in vec {
        let newdate = date.format("%Y-%m-%d");
        write!(&mut stdin, "{} {}\n", newdate, hours)?;
    }

    Ok(())
}

fn load_and_show(reader: &mut Reader<File>, duration: Duration, end_date: NaiveDateTime) -> Result<()> {
    let data = load_data(reader, duration, end_date)?;
    show(&data, duration)
}

fn load_data(reader: &mut Reader<File>, duration: Duration, end_date: NaiveDateTime) -> Result<HashMap<NaiveDate, f32>> {
    let mut entries = HashMap::new();
    for entry in reader.deserialize() {
        let entry: Entry = entry?;
        let date = NaiveDateTime::parse_from_str(&entry.start_date, "%Y-%m-%dT%H:%M:%S")?;

        if end_date - date <= duration {
            entries.entry(date.date()).and_modify(|e| *e += entry.total_hours).or_insert(entry.total_hours);
        }
    }
    Ok(entries)
}

fn main() -> Result<()> {
    let args = Args::parse();
    let mut reader = ReaderBuilder::new().delimiter(b';').from_path(&args.path)?;
    let now = chrono::Local::now().naive_local();

    if args.ytd {
        load_and_show(&mut reader, Duration::days(365), now)?;
    } else if args.mtd {
        load_and_show(&mut reader, Duration::days(30), now)?;
    } else if args.wtd {
        load_and_show(&mut reader, Duration::days(7), now)?;
    } else {
        if let Some(start_date) = &args.start_date {
            let start_date = DateTime::<Local>::from_str(&start_date)?.naive_local();
            let end_date = match &args.start_date {
                Some(date) => chrono::DateTime::<Local>::from_str(date)?.naive_local(),
                None => now,
            };
            load_and_show(&mut reader, end_date - start_date, end_date)?;
        }
        else {
            return Err(anyhow::anyhow!("Invalid arguments"));
        }
    }

    Ok(())
}
