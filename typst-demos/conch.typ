#set page(width: 13cm, height: auto, margin: 6pt, fill: white)
#set text(font: ("Libertinus Serif", "Noto Sans SC"), size: 9pt)

// conch 0.1.0：把终端会话写成 Typst 源码——不截图，编译即得可复现、可版本管理的终端画面。
// 终端正文里每一行都会被当成命令真的执行，所以写英文；python3 / pip 不在内置命令表里，
// 用 Typst 函数插件补上：它们的输出真的来自下面这个虚拟文件系统
//（读 data/samples.csv 算均值、读 requirements.txt 列依赖）。
#import "@preview/conch:0.1.0": system, terminal-block

#let requirements = "rich==13.7.1\npandas==2.2.2\n"
#let samples = "name,value\nalpha,12.5\nbeta,8.25\ngamma,18.5\ndelta,10.25\n"
#let report-py = "import csv, sys

rows = list(csv.DictReader(open(sys.argv[1])))
vals = [float(r[\"value\"]) for r in rows]
print(\"rows:\", len(vals))
print(\"mean:\", round(sum(vals) / len(vals), 3))
"

// 按脚本里的算法，从虚拟 CSV 真算一遍，保证 cat 出来的代码和运行结果对得上
#let stats(csv) = {
  let vals = csv
    .trim()
    .split("\n")
    .slice(1)
    .filter(l => l != "")
    .map(l => float(l.split(",").at(1)))
  (n: vals.len(), mean: calc.round(vals.sum() / vals.len(), digits: 3))
}

#let python3(args, stdin, files) = {
  let script = args.at(0, default: "")
  let data = if args.len() > 1 { files.at(args.at(1), default: "") } else { "" }
  if script not in files or data == "" {
    return (
      stdout: "python3: can't open file '" + script + "': [Errno 2] No such file or directory\n",
      exit-code: 2,
    )
  }
  let s = stats(data)
  (stdout: "rows: " + str(s.n) + "\nmean: " + str(s.mean) + "\n", exit-code: 0)
}

#let pip(args, stdin, files) = {
  // `pip install -r requirements.txt`：依赖清单也从虚拟文件系统里读
  let spec = if args.len() >= 3 and args.at(1) == "-r" {
    files.at(args.at(2), default: "")
  } else {
    args.slice(1).filter(a => not a.starts-with("-")).join("\n")
  }
  let pkgs = spec.trim().split("\n").filter(l => l != "")
  let newest = pkgs.last().split("==")
  let lines = pkgs.map(p => "Collecting " + p)
  lines.push("  Downloading " + newest.at(0) + "-" + newest.at(1) + "-py3-none-any.whl (11.0 MB)")
  lines.push(
    "\u{1b}[1;32mSuccessfully installed "
      + pkgs.map(p => p.replace("==", "-")).join(" ")
      + "\u{1b}[0m",
  )
  (stdout: lines.join("\n") + "\n", exit-code: 0)
}

#terminal-block(
  system: system(
    hostname: "conch",
    files: (
      "requirements.txt": requirements,
      "data/samples.csv": samples,
      "src/report.py": report-py,
    ),
    plugins: (("python3", python3), ("pip", pip)),
  ),
  user: "demo",
  theme: "dracula",
  font: (font: ("Cascadia Mono", "DejaVu Sans Mono"), size: 9pt),
  width: 100%,
)[```
ls -la
cat src/report.py
python3 src/report.py data/samples.csv
pip install -r requirements.txt
cd src && wc -l report.py
```]
