# 我的技术博客

一个用 [MkDocs](https://www.mkdocs.org/) + [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
搭起来的技术博客脚手架。内容全是占位的，换成自己的就行。

- 文章用 Markdown 写，`docs/blog/posts/` 下面丢一个 `.md` 就是一个新帖子
- 正文和代码字体都是[霞鹜文楷（LXGW WenKai）](https://github.com/lxgw/LxgwWenKai)，
  **字体自托管，不依赖任何 CDN**
- 自带搜索、标签、归档、分类、RSS、图片灯箱、页脚更新日期

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
├── mkdocs.yml                  # 全部配置
├── requirements.txt
├── docs/
│   ├── index.md                # 首页
│   ├── about.md
│   ├── tags.md                 # 标签索引，内容由 tags 插件注入
│   ├── blog/
│   │   ├── index.md            # 博客入口（列表由 blog 插件生成）
│   │   ├── .authors.yml        # 作者信息
│   │   └── posts/              # ← 文章都放这里
│   ├── notes/                  # 笔记
│   ├── stylesheets/extra.css   # 自定义样式 + 字体变量
│   └── assets/
│       ├── fonts/lxgw-wenkai/  # 自托管字体（woff2 子集 + OFL 许可）
│       └── images/
└── site/                       # 构建产物，已 gitignore
```

## 写一篇新文章

在 `docs/blog/posts/` 下新建 `你的文件名.md`：

```markdown
---
date: 2025-02-01
slug: my-post-slug
categories:
  - Python
tags:
  - asyncio
authors:
  - your-name
---

# 标题

摘要部分写在 `<!-- more -->` 之前，会显示在博客列表里。

<!-- more -->

正文……
```

- `date` 决定归档位置，最终地址是 `/blog/2025/02/01/my-post-slug/`
- `slug` 决定 URL 里的最后一段。**不写的话会用标题做 slug**，
  中文标题会变成百分号编码的地址，所以建议显式写一个英文 slug
- 作者 id 要在 `docs/blog/.authors.yml` 里先定义好
- `categories` 可以省略；标签插件读的是 `tags`

## 换成你自己的信息

需要改的地方都留了 `你的名字` / `your-name` / `example.com` 这类占位：

| 文件 | 改什么 |
| --- | --- |
| `mkdocs.yml` | `site_name`、`site_url`、`site_author`、`copyright`、`repo_url`、`repo_name`、`edit_uri`、`extra.social`、rss 插件的 `image` |
| `docs/blog/.authors.yml` | 作者名字、简介、头像、主页 |
| `docs/about.md` | 自我介绍和联系方式 |
| `docs/assets/images/` | `logo.svg`、`favicon.svg`、`avatar.svg`、`feed-logo.png` 换成自己的 |

改完 `repo_url` 之后，页面右上角的「编辑此页」才会指向正确的地址。

`site_url` 和 rss 插件的 `image` 都得改：前者影响 RSS 里的链接和 sitemap，
后者是 feed 的频道图标（必须绝对地址，插件不会自动补 `site_url`）。

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
| 文章页（含代码块） | 39 | ≈ 2.0 MB |

子集是一次下载、全站复用的，翻第二篇文章时基本命中缓存。
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

想换别的字体，把 `extra_css` 里的字体 CSS 换掉，
再改 `extra.css` 里的 `--md-text-font` / `--md-code-font` 即可。

## 已装的插件

| 插件 | 用途 |
| --- | --- |
| `search`（内置） | 站内搜索，中文分词靠 `jieba` |
| `blog`（内置） | 文章列表、分页、归档、分类、作者、阅读时长 |
| `tags`（内置） | 标签索引页 |
| `mkdocs-minify-plugin` | 压缩 HTML / CSS / JS |
| `mkdocs-git-revision-date-localized-plugin` | 页脚显示创建 / 更新日期 |
| `mkdocs-rss-plugin` | 生成 `feed_rss_created.xml` |
| `mkdocs-glightbox` | 图片点击放大 |
| `mkdocs-macros-plugin` | Markdown 里可用 Jinja2 变量（按页开启） |

## 配置里踩过的坑

搭这个脚手架时实际踩到并修掉的，改配置前建议先看一眼。

!!! danger "1. `minify` 的 `css_files` 必须写精确路径，不能写 glob"

    插件在 `on_pre_build` 阶段靠**字符串精确匹配**把 `extra_css` 里的条目
    改写成 `xxx.min.css`，然后在 `on_post_build` 阶段按 `css_files` 去压缩和改名。

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

!!! danger "2. `blog` 插件的入口在导航里必须有父级"

    `mkdocs.yml` 里不能写：

    ```yaml
    nav:
      - 博客: blog/index.md        # ← 错！这是一个没有父级的顶层 Page
    ```

    要写成 section 形式：

    ```yaml
    nav:
      - 博客:
          - blog/index.md          # ← 对，配合 navigation.indexes 当落地页
    ```

    插件源码里的判断是 `if not self.blog.parent: inclusion = NOT_IN_NAV`。
    入口没有父级时，归档 / 分类 / 作者三个页面**照样会生成、能直接访问**，
    但一个都不会挂到导航上，很容易以为是自己配置写错了。

!!! warning "3. `tags_file` 在 Material 9.7 已废弃"

    不要再写 `tags_file: tags.md`，会收到 deprecation 警告。
    现在只需要在任意页面里放一个 `<!-- material/tags -->` 指令，
    索引就会注入到那个位置。

!!! warning "4. `git-revision-date-localized` 依赖 git 历史"

    目录不是 git 仓库，或者文件还没提交过，构建会报错。
    配置里已经加了 `fallback_to_build_date: true` 兜底。

!!! warning "5. `rss` 插件默认 `use_git: true`"

    非 git 仓库下会刷警告。这里已经显式设成 `use_git: false`，
    日期只认 front matter 里的 `date`。

!!! note "6. `macros` 插件默认会渲染所有页面"

    `{{ }}` 写在代码块里也会被 Jinja 吃掉——技术博客迟早会写到
    Jinja / Go template / Vue / Helm 的片段，这是个定时炸弹。
    所以配置里设了 `render_by_default: false`，
    只在 front matter 写了 `render_macros: true` 的页面才渲染。

!!! note "7. 文章 URL 的 slug 来自标题，不是文件名"

    `blog` 插件的 `post_slugify` 作用在**标题**上，中文标题会生成
    百分号编码的 URL。示例文章都在 front matter 里显式写了 `slug:`，
    想全局改成 ASCII 就自己替换 `post_slugify`。

!!! note "8. `repo_url` 会触发一次 api.github.com 请求"

    Material 用它拉 star / fork 数。仓库地址换成真的之后才有效，
    占位地址下控制台会有一条 404，不影响任何功能。

## 可选：数学公式

默认没开。需要的话：

1. 装 MathJax 配置，新建 `docs/javascripts/mathjax.js`：

   ```js
   window.MathJax = {
     tex: {
       inlineMath: [["\\(", "\\)"]],
       displayMath: [["\\[", "\\]"]],
       processEscapes: true,
       processEnvironments: true
     },
     options: {
       ignoreHtmlClass: ".*|",
       processHtmlClass: "arithmatex"
     }
   };
   ```

2. `mkdocs.yml` 里打开 `extra_javascript` 的两行，并在
   `markdown_extensions` 里加上：

   ```yaml
   - pymdownx.arithmatex:
       generic: true
   ```

## 部署

`site/` 是纯静态文件，丢哪儿都行。

- **GitHub Pages**：`mkdocs gh-deploy`，或者用 Actions 跑 `mkdocs build --strict`
- **Cloudflare Pages / Vercel**：构建命令 `mkdocs build`，输出目录 `site`
- **自己的服务器**：Nginx 指向 `site/` 就行

记得把 `mkdocs.yml` 里的 `site_url` 改成真实域名，
`site_url` 会影响 RSS 里的链接和 sitemap。
