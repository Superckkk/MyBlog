# 我的技术博客

> 线上地址：**<https://turingckkk.com/>**

一个用 [MkDocs](https://www.mkdocs.org/) + [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
搭起来的技术笔记站。

- 笔记用 Markdown 写，放在 `docs/notes/` 下，目录结构和 `typst/` 里的原始笔记一一对应
- 正文和代码字体都是[霞鹜文楷（LXGW WenKai）](https://github.com/lxgw/LxgwWenKai)，
  **字体自托管，不依赖任何 CDN**
- 自带搜索、标签、图片灯箱、页脚更新日期、站内 PDF 阅读器
- 数学公式走 MathJax（全站唯一的外部依赖）

## 快速开始

Windows PowerShell：

```powershell
python -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements.txt
.venv\Scripts\python.exe -m mkdocs serve
```

macOS / Linux：

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/python -m mkdocs serve
```

然后打开 <http://127.0.0.1:8000/>。

构建静态文件：

```bash
.venv/bin/python -m mkdocs build --strict
# 产物在 site/
```

## 目录结构

```text
.
├── mkdocs.yml                     # 全部配置
├── requirements.txt
├── docs/
│   ├── index.md                   # 首页
│   ├── about.md
│   ├── tags.md                    # 标签索引，内容由 tags 插件注入
│   ├── notes/                     # ← 笔记都在这里
│   │   ├── index.md
│   │   ├── AI/                    # 和 typst/AI 对应
│   │   │   └── DeepLearning/
│   │   ├── Coding/                # 和 typst/Coding 对应
│   │   │   └── python/
│   │   ├── ComputerScience/       # 和 typst/ComputerScience 对应
│   │   │   └── TCS/
│   │   │       ├── index.md       # PDF 阅读页
│   │   │       └── TCS.pdf
│   │   └── Tools/                 # 和 typst/Tools 对应
│   │       ├── Typst.md
│   │       └── Else.md
│   ├── javascripts/mathjax.js     # MathJax 配置
│   ├── stylesheets/extra.css      # 自定义样式 + 字体变量 + PDF 阅读器
│   └── assets/
│       ├── fonts/lxgw-wenkai/     # 自托管字体（woff2 子集 + OFL 许可）
│       ├── images/                # logo / favicon / 头像
│       └── typst/                 # Typst 包效果图（由脚本生成）
├── typst/                         # Typst 原始笔记（内容源头）
├── typst-demos/                   # 每个 Typst 包的最小可编译示例
├── scripts/
│   └── render-typst-demos.ps1     # 重新渲染 docs/assets/typst/*
└── site/                          # 构建产物，已 gitignore
```

## 写一篇新笔记

在 `docs/notes/` 下按主题放一个新的 `.md`，然后到 `mkdocs.yml` 的 `nav:` 里补一行。

```markdown
---
tags:
  - 深度学习
  - PyTorch
---

# 标题

正文……
```

只有 `tags` 是插件读的，其余 front matter 随便加。
标签会汇总到[标签页](docs/tags.md)。

## Typst 笔记怎么同步到站点

`typst/` 是原始笔记，站点里的 Markdown 是它的搬运版。Typst 的语法和 Markdown
差得不算远，手工搬运时注意这几处：

| Typst | Markdown |
| --- | --- |
| `= 标题` / `==` / `===` | `#` / `##` / `###` |
| `` `code` `` | 一样 |
| ` ```py ` 围栏 | 一样，但语言名写在围栏后（`python`） |
| `$d_0, dots.c, d_(n-1)$` | `$d_0, \dots, d_{n-1}$`——**Typst 数学不是 LaTeX**，要翻译 |
| `- 列表` | 一样 |
| `#image("x.png")` | `![说明](x.png)` |

数学公式是最容易出错的地方：Typst 里 `dots.c`、`bb(R)`、`frac(a, b)` 这些写法
在 MathJax 里都不认，得换成 `\dots`、`\mathbb{R}`、`\frac{a}{b}`。

## Typst 包效果图

`docs/notes/Tools/Typst.md` 里每个包都配了一张渲染出来的效果图。
图不是截图，是用 `typst compile` 从 `typst-demos/*.typ` 真编出来的：

```powershell
pwsh -File scripts/render-typst-demos.ps1
```

脚本会把每个 `.typ` 编成 PNG 放进 `docs/assets/typst/`。
改了示例重新跑一遍就行，不用手动截图。

想加一个新包的演示：在 `typst-demos/` 里放一个 `.typ`，跑脚本，
然后在 `Typst.md` 里加一段。

!!! tip "为什么用 PNG 而不是 SVG"

    `typst compile` 也能出 SVG，但 SVG 里的文字是引用字体名的，
    访问者的机器上没装那个字体就会走样。PNG 是渲染好的位图，到哪儿都一样。

## 换成你自己的信息

域名、仓库、作者这些**已经填好了**（`turingckkk.com` / `Superckkk/MyBlog` / `ckkk`）。
剩下这些还是通用占位，想改再动：

| 文件 | 改什么 | 现在的值 |
| --- | --- | --- |
| `mkdocs.yml` | `site_name` | `我的技术博客` |
| `mkdocs.yml` | `site_description` | `学习笔记与技术备忘` |
| `docs/about.md` | 自我介绍、联系方式 | 学校专业 + GitHub 链接 |
| `docs/assets/images/` | `logo.svg`、`favicon.svg`、`avatar.svg` | 靛蓝配色的占位图形 |

`extra.social` 里的邮箱图标是注释掉的——不想公开邮箱就不用管它。

改完 `site_name` 或 `repo_url` 记得本地 `mkdocs build --strict` 跑一遍再推。

## 字体

### 现状

`docs/assets/fonts/lxgw-wenkai/` 里是三个字重的子集：

| 文件 | 字族 | 字重 |
| --- | --- | --- |
| `lxgwwenkai-regular.css` | `LXGW WenKai` | 400 |
| `lxgwwenkai-bold.css` | `LXGW WenKai` | 700 |
| `lxgwwenkaimono-regular.css` | `LXGW WenKai Mono` | 400 |

每个 CSS 里是 97 条 `@font-face`，用 `unicode-range` 切分，
浏览器只下载当前页面真正用到的那几个子集。

实测（Chromium，1440px，本地未压缩传输）：

| 页面 | 下载的子集数 | 体积 |
| --- | --- | --- |
| 首页 | 25 | ≈ 1.3 MB |
| 内容页（含代码块） | 39 | ≈ 2.0 MB |

子集是一次下载、全站复用的，翻第二页时基本命中缓存。
首次访问 1–2 MB 对中文字体站点来说属于正常范围，
真嫌大的话见下面「瘦身」。

字体以 [SIL Open Font License 1.1](https://openfontlicense.org/) 授权，
许可全文见 `docs/assets/fonts/lxgw-wenkai/OFL.txt`。

### 瘦身

按性价比排序：

1. **只保留正文 Regular + Mono Regular，删掉 `lxgwwenkai-bold.css`。**
   体积大约腰斩，代价是标题和 `<strong>` 由浏览器合成粗体，
   楷体的合成粗体会有点糊。
2. **换 GB 变体**（`lxgwwenkaigb*`，覆盖 GB 18030 二级字库），
   字符集更小，全集从 4.87 MB 降到 4.33 MB。
3. **换 Lite 变体**（`lxgw-wenkai-lite-webfont`），剔除谚文和生僻字。
4. **干脆不自托管**，改回 `theme.font` + Google Fonts，
   但要接受国内访问不稳定，以及 Google Fonts 上「霞鹜文楷」的字重
   和 Material 请求的 `300,300i,400,400i,700,700i` 对不上。

### 主题是怎么接上去的

`mkdocs.yml` 里关掉了 Material 自带的字体请求：

```yaml
theme:
  font: false
```

然后在 `docs/stylesheets/extra.css` 里给主题的两个 CSS 变量赋值：

```css
:root {
  --md-text-font: "LXGW WenKai", -apple-system, "PingFang SC", sans-serif;
  --md-code-font: "LXGW WenKai Mono", ui-monospace, monospace;
}
```

### 想换字体 / 补字重

字体来自 npm 包 [lxgw-wenkai-webfont](https://github.com/chawyehsu/lxgw-wenkai-webfont)
（另有 Lite / TC / Screen 几个变体）。补一个字重：

```bash
npm pack lxgw-wenkai-webfont@1.7.0
tar -xzf lxgw-wenkai-webfont-1.7.0.tgz
# 把 package/lxgwwenkai-light.css 和 package/files/lxgwwenkai-light-subset-*.woff2
# 拷进 docs/assets/fonts/lxgw-wenkai/，再往 mkdocs.yml 的 extra_css 里加一行
```

CSS 里的 `url('./files/...')` 是相对路径，跟着 CSS 文件自己的位置解析，
所以目录结构照搬就好，不用改内容。

## 站内 PDF 阅读器

讲义类的内容直接嵌 PDF，用浏览器自带的查看器，不引入 pdf.js。

目录必须长这样，因为 `<iframe>` 的 `src` 是相对路径：

```text
docs/notes/ComputerScience/TCS/
├── index.md      # 页面
└── TCS.pdf       # 和 index.md 同级，src 写 "TCS.pdf"
```

`index.md` 里：

```html
<div class="pdf-viewer">
  <iframe src="TCS.pdf" title="讲义"></iframe>
</div>
```

样式（边框、高度）在 `docs/stylesheets/extra.css` 的 `.pdf-viewer` 里调。
移动端浏览器大多不会内联显示 PDF，所以页面上最好另外给一个下载链接。

## 数学公式

已经开好了，行内写 `$...$`，独立成行写 `$$...$$`，语法是 **LaTeX**（MathJax 3）。

```yaml
markdown_extensions:
  - pymdownx.arithmatex:
      generic: true
extra_javascript:
  - javascripts/mathjax.js
  - https://unpkg.com/mathjax@3/es5/tex-mml-chtml.js
```

引擎本体走 CDN，是全站唯一的外部依赖。要完全离线就把上面
`extra_javascript` 的两行删掉，代价是公式会显示成原始的 `$...$`。

`processHtmlClass: "arithmatex"` 让 MathJax 只处理公式块，
正文里出现的普通 `$` 不会被误伤。

## 已装的插件

| 插件 | 用途 |
| --- | --- |
| `search`（内置） | 站内搜索，中文分词靠 `jieba` |
| `tags`（内置） | 标签索引页 |
| `mkdocs-minify-plugin` | 压缩 HTML / CSS / JS |
| `mkdocs-git-revision-date-localized-plugin` | 页脚显示创建 / 更新日期 |
| `mkdocs-glightbox` | 图片点击放大 |

## 配置里踩过的坑

搭这个站时实际踩到并修掉的，改配置前建议先看一眼。

!!! danger "1. `minify` 的 `css_files` / `js_files` 必须写精确路径，不能写 glob"

    插件在 `on_pre_build` 阶段靠**字符串精确匹配**把 `extra_css` /
    `extra_javascript` 里的条目改写成 `xxx.min.css`，然后在 `on_post_build`
    阶段按 `css_files` 去压缩和改名。

    ```yaml
    extra_css:
      - stylesheets/extra.css
    plugins:
      - minify:
          css_files:
            - stylesheets/*.css      # ← 错！改名会发生，引用不会改，页面 404
            - stylesheets/extra.css  # ← 对，和 extra_css 里一字不差
    ```

    写 glob 的后果很隐蔽：构建不报错，`site/stylesheets/extra.min.css` 也生成了，
    但 HTML 里还在引用 `extra.css`，于是自定义样式（包括字体变量）全部静默失效。

!!! warning "2. `tags_file` 在 Material 9.7 已废弃"

    不要再写 `tags_file: tags.md`，会收到 deprecation 警告。
    现在只需要在任意页面里放一个 `<!-- material/tags -->` 指令，
    索引就会注入到那个位置。

!!! warning "3. `git-revision-date-localized` 依赖 git 历史"

    目录不是 git 仓库，或者文件还没提交过，构建会报错。
    配置里已经加了 `fallback_to_build_date: true` 兜底。

!!! warning "4. `<iframe>` 的路径不会被 MkDocs 改写"

    Markdown 链接（`[x](a.pdf)`）和 `![](a.png)` 会被 MkDocs 按页面 URL
    重写成相对路径，但裸 HTML 里的 `src="a.pdf"` 原样输出。
    所以 PDF 必须和 `index.md` 放在同一层目录，用它俩共同的 URL 前缀兜住。

!!! note "5. `repo_url` 会触发一次 api.github.com 请求"

    Material 用它拉 star / fork 数。未登录的请求每个 IP 每小时只有 60 次配额，
    本地反复刷新页面或者批量脚本打得太密时会看到 403，
    属于正常现象，不影响站点功能。

!!! note "6. 如果以后要加 `macros` 插件，记得设 `render_by_default: false`"

    它默认会把所有页面丢给 Jinja 渲染，**代码块里的 `{{ }}` 也会被吃掉**。
    技术笔记迟早会写到 Jinja / Go template / Vue / Helm 的片段，
    全局开着是个定时炸弹：

    ```yaml
    - macros:
        render_by_default: false
    ```

    然后在需要用的页面 front matter 里写 `render_macros: true`。

!!! danger "7. 别给 `pymdownx.betterem` 加 `smart_enable: all`"

    Material 官方文档推荐这么写，但**它会让中文加粗全线失效**。

    `smart_strong` 靠 `\w` 判断词边界，而 Python 的正则里 `\w` **是匹配汉字的**。
    中文没有空格，`是**粗体**：` 的两个 `**` 前后都是「词字符」，
    于是被判成「词中间出现的星号」直接拒绝加粗——页面上原样显示 `**粗体**`。

    改配置时很容易照着官方文档把它加回来，加完页面也不会报错，只是加粗悄悄没了：

    ```yaml
    # 不要这样写
    - pymdownx.betterem:
        smart_enable: all
    ```

    ```yaml
    # 正确
    - pymdownx.betterem
    ```

    排查提示：这类问题在单文件小样例里复现不出来。用 `markdown.Markdown(extensions=[...])`
    手动转换时，列表里的 `{扩展名: {配置}}` 字典形式未必会生效，
    表现和 MkDocs 实际构建不一致。**要验证就得 `mkdocs build` 完再看产物。**

## 部署

站点跑在 **GitHub Pages** 上，域名 `turingckkk.com`，仓库
[Superckkk/MyBlog](https://github.com/Superckkk/MyBlog)。

### 它是怎么工作的

推送到 `main` 之后，`.github/workflows/deploy.yml` 会自动：

1. 全量检出（`fetch-depth: 0`，否则 `git-revision-date-localized` 拿不到提交历史，页脚日期会全变成构建时间）
2. 装 `requirements.txt` 里的依赖
3. `mkdocs build --strict`（有警告就直接失败，不会把坏页面发上去）
4. 把 `site/` 作为 artifact 上传，交给 `actions/deploy-pages` 发布

所以日常只需要 `git push`，不用在本地构建。

### 首次部署要做的两件事

仓库 Settings → Pages：

| 项目 | 值 |
| --- | --- |
| Build and deployment → Source | **GitHub Actions** |
| Custom domain | `turingckkk.com` |

`docs/CNAME` 里已经写了域名，Custom domain 一般会自动带出来，但确认一下更稳妥。
等 DNS 生效、证书签发完成（通常几分钟到几小时），再勾上 **Enforce HTTPS**。

### DNS

`turingckkk.com` 的解析在阿里云（万网）。GitHub Pages 需要：

| 主机记录 | 类型 | 记录值 |
| --- | --- | --- |
| `@` | A | `185.199.108.153` |
| `@` | A | `185.199.109.153` |
| `@` | A | `185.199.110.153` |
| `@` | A | `185.199.111.153` |
| `www` | CNAME | `turingckkk.com` |

这四条 A 记录已经配好了。**但 `www` 目前 CNAME 指向 `superckkk.github.io`**，
那是另一个站点（Hippo 英语测评），不改的话 `www.turingckkk.com` 会跑到那边去。
把 `www` 的 CNAME 改成 `turingckkk.com` 即可。

（可选）想要 IPv6 就再加四条 AAAA：
`2606:50c0:8000::153`、`2606:50c0:8001::153`、`2606:50c0:8002::153`、`2606:50c0:8003::153`。

### 手动部署（备选）

不想走 Actions 的话，本地构建后直接推 `gh-pages` 分支：

```bash
.venv/bin/python -m mkdocs gh-deploy --force
```

对应地要把 Settings → Pages → Source 改成「Deploy from a branch」，分支选 `gh-pages`。
两种方式不要同时开。

### 先在本地验一遍

```bash
.venv/bin/python -m mkdocs build --strict   # CI 里跑的就是这条
.venv/bin/python -m mkdocs serve            # 打开 http://127.0.0.1:8000/
```

### 其它平台

`site/` 就是一堆静态文件，也能直接丢给别的托管：

- **Cloudflare Pages / Vercel**：构建命令 `mkdocs build`，输出目录 `site`
- **自己的服务器**：Nginx 指向 `site/`
