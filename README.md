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

文件名会作为 URL 里的 slug，日期决定归档位置，
最终地址是 `/blog/2025/02/01/你的文件名/`。

作者 id 要在 `docs/blog/.authors.yml` 里先定义好。

## 换成你自己的信息

需要改的地方都留了 `你的名字` / `your-name` / `example.com` 这类占位：

| 文件 | 改什么 |
| --- | --- |
| `mkdocs.yml` | `site_name`、`site_url`、`site_author`、`copyright`、`repo_url`、`repo_name`、`edit_uri`、`extra.social` |
| `docs/blog/.authors.yml` | 作者名字、简介、头像、主页 |
| `docs/about.md` | 自我介绍和联系方式 |
| `docs/assets/images/` | `logo.svg`、`favicon.svg`、`avatar.svg` 换成自己的 |

改完 `repo_url` 之后，页面右上角的「编辑此页」才会指向正确的地址。

## 字体

### 现状

`docs/assets/fonts/lxgw-wenkai/` 里是三个字重的子集：

| 文件 | 字族 | 字重 |
| --- | --- | --- |
| `lxgwwenkai-regular.css` | `LXGW WenKai` | 400 |
| `lxgwwenkai-bold.css` | `LXGW WenKai` | 700 |
| `lxgwwenkaimono-regular.css` | `LXGW WenKai Mono` | 400 |

每个 CSS 里是 97 条 `@font-face`，用 `unicode-range` 切分，
浏览器只会下载当前页面真正用到的那几个子集（通常 300–500 KB）。

字体以 [SIL Open Font License 1.1](https://openfontlicense.org/) 授权，
许可全文见 `docs/assets/fonts/lxgw-wenkai/OFL.txt`。

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
| `mkdocs-macros-plugin` | Markdown 里可用 Jinja2 变量 |

!!! warning "两个容易踩的坑"

    **`minify` 插件光写 `minify_css: true` 是不生效的**，
    必须同时给 `css_files` / `js_files` 的 glob，否则它一个文件都不处理。

    **`git-revision-date-localized` 依赖 git 历史。** 目录不是 git 仓库，
    或者文件没提交过，构建会报错。配置里已经加了
    `fallback_to_build_date: true` 兜底。

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
