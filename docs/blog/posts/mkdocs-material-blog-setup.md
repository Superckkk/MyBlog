---
date: 2025-01-12
slug: mkdocs-material-blog-setup
categories:
  - 建站
tags:
  - MkDocs
  - Material
  - 字体
authors:
  - your-name
---

# 用 MkDocs Material 搭一个能长期写下去的博客

就是你现在看到的这个站。这篇占位文章顺手把技术选型和几个必须踩的坑记下来，
以后换机器重建的时候不用再翻文档。

<!-- more -->

## 为什么是 MkDocs 而不是 Hexo / Hugo

需求很朴素：写 Markdown、本地能预览、构建产物是纯静态文件、能塞进 git。

选 MkDocs 主要因为两件事：

1. **配置是 YAML，不是模板语言。** 改个导航、加个插件不用学一套 DSL。
2. **Material 主题自带的博客插件够用。** 分页、归档、分类、标签、作者、
   阅读时长、RSS，装完就有，不用自己写模板。

代价是构建比 Hugo 慢，几百篇文章之后可能要几十秒。
不过博客这个体量，一年也就几十篇，无所谓。

## 目录结构

```text
.
├── mkdocs.yml              # 全部配置都在这里
├── requirements.txt
├── docs/
│   ├── index.md            # 首页
│   ├── about.md
│   ├── tags.md             # 标签索引（内容由插件注入）
│   ├── blog/
│   │   ├── index.md        # 博客入口
│   │   ├── .authors.yml    # 作者信息
│   │   └── posts/          # 文章源文件
│   ├── notes/              # 不成篇的笔记
│   ├── stylesheets/
│   │   └── extra.css
│   └── assets/
│       ├── fonts/lxgw-wenkai/
│       └── images/
└── site/                   # 构建产物，已 gitignore
```

## 装的插件

| 插件 | 干什么 |
| --- | --- |
| `search`（内置） | 站内搜索。**中文必须装 `jieba`**，否则搜中文基本没结果 |
| `blog`（内置） | 文章列表、分页、归档、分类、作者、阅读时长 |
| `tags`（内置） | 标签索引页 |
| `minify` | 压缩 HTML / CSS / JS |
| `git-revision-date-localized` | 页脚显示创建与最后更新日期 |
| `rss` | 生成订阅源 |
| `glightbox` | 图片点击放大 |
| `macros` | Markdown 里能用 Jinja2 变量 |

两个容易翻车的点：

**其一，`minify` 插件光写 `minify_css: true` 是不生效的**，
必须同时给出 `css_files` / `js_files` 的 glob，否则它一个文件都不处理：

```yaml
- minify:
    minify_html: true
    minify_css: true
    minify_js: true
    css_files:
      - stylesheets/*.css
```

**其二，`git-revision-date-localized` 依赖 git 历史。**
如果目录不是 git 仓库，或者文件还没提交过，构建会报错。
加一个兜底就不会挂：

```yaml
- git-revision-date-localized:
    fallback_to_build_date: true
```

## 字体：霞鹜文楷

正文字体用的是[霞鹜文楷](https://github.com/lxgw/LxgwWenKai)，
楷体读长文比黑体舒服，缺点是只有三档字重，英文部分也不算好看。

### 为什么不用 Google Fonts

Material 的 `theme.font` 配置很方便，填个字体名就会去 Google Fonts 拉。
但有两个问题：一是国内访问不稳定，二是 Google Fonts 上「霞鹜文楷」的字重
和 Material 请求的 `300,300i,400,400i,700,700i` 对不上，容易 404。

所以直接关掉，改成自托管：

```yaml
theme:
  font: false   # 关掉主题的字体请求
```

然后在 `extra.css` 里给主题的两个变量赋值，主题的样式表会直接用：

```css
:root {
  --md-text-font: "LXGW WenKai", -apple-system, "PingFang SC", sans-serif;
  --md-code-font: "LXGW WenKai Mono", ui-monospace, monospace;
}
```

### 字体文件怎么来的

用 [lxgw-wenkai-webfont](https://github.com/chawyehsu/lxgw-wenkai-webfont)
这个 npm 包，它已经把字体按 `unicode-range` 切成了 97 个 woff2 子集。

```powershell
# 只取需要的字重：正文 Regular + Bold，等宽 Regular
npm pack lxgw-wenkai-webfont@1.7.0
tar -xzf lxgw-wenkai-webfont-1.7.0.tgz
```

把 `lxgwwenkai-regular.css`、`lxgwwenkai-bold.css`、
`lxgwwenkaimono-regular.css` 连同 `files/` 目录一起拷到
`docs/assets/fonts/lxgw-wenkai/`，再在 `mkdocs.yml` 里挂上：

```yaml
extra_css:
  - assets/fonts/lxgw-wenkai/lxgwwenkai-regular.css
  - assets/fonts/lxgw-wenkai/lxgwwenkai-bold.css
  - assets/fonts/lxgw-wenkai/lxgwwenkaimono-regular.css
  - stylesheets/extra.css
```

CSS 里的 `url('./files/...')` 是相对路径，会跟着 CSS 文件自己的位置解析，
所以目录结构照搬就行，不用改任何一行。

### 效果

浏览器只会下载当前页面真正出现过的那几个子集。
一篇文章通常命中 10 个左右的子集，加起来 300–500 KB，
比直接上一个几 MB 的完整字体好得多，也比走 CDN 稳。

!!! note "关于字重"

    霞鹜文楷本体有 Light 300 / Regular 400 / Bold 700 三档，
    但等宽版只有 Regular。代码块里的粗体是浏览器合成的，
    在 13px 左右基本看不出来，可以接受。

### 一个细节

Material 的 CSS 里写的是 `var(--md-text-font, _)`，
后面的 `_` 是个故意写错的值，用来占位的。
所以只要自己定义了 `--md-text-font`，主题原本的 Roboto 就完全不会加载。

## 顺带调的中文排版

```css
.md-typeset {
  line-height: 1.8;          /* 中文比拉丁文需要更松的行距 */
  letter-spacing: 0.01em;
}
```

主题默认的 `h1` 字重是 300，但霞鹜文楷最细只有 400，
浏览器拿不到更细的字重会直接退回 400，标题看上去和正文一样粗。
干脆统一压到 700：

```css
.md-typeset h1,
.md-typeset h2,
.md-typeset h3 {
  font-weight: 700;
}
```

## 部署

`mkdocs build` 出来的 `site/` 目录扔哪都能跑，
GitHub Pages、Cloudflare Pages、自己的 Nginx 都行。

```bash
mkdocs build --strict   # 有任何警告就失败，适合放进 CI
```

本地写东西的时候开着 `mkdocs serve`，存盘即刷新，
改 `mkdocs.yml` 大部分也能热更新，少数情况要重启。
