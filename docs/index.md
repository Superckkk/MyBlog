---
# 打开 Jinja2 渲染，这样下面才能用 {{ config.site_url }}
# （mkdocs.yml 里 macros 插件设的是 render_by_default: false，按页开关）
render_macros: true
---

# 我的技术博客

写点工程实践、源码阅读，还有一些没地方放的零碎想法。
内容大都是给自己留的备忘，如果刚好对你有用，那就更好了。

<div class="grid cards" markdown>

-   :material-notebook-edit-outline:{ .lg .middle } __博客__

    ---

    相对完整的文章。踩过的坑、读过的源码、做过的取舍，尽量写清楚前因后果。

    [:octicons-arrow-right-24: 去看文章](blog/index.md)

-   :material-file-document-multiple-outline:{ .lg .middle } __笔记__

    ---

    不成篇的片段。命令、配置、API 速查，写给自己看的，排版不讲究。

    [:octicons-arrow-right-24: 翻笔记](notes/index.md)

-   :material-tag-multiple-outline:{ .lg .middle } __标签__

    ---

    按主题把所有内容串起来，找东西比翻目录快。

    [:octicons-arrow-right-24: 按标签浏览](tags.md)

-   :material-account-outline:{ .lg .middle } __关于__

    ---

    我是谁、在做什么、这个站点是怎么搭起来的。

    [:octicons-arrow-right-24: 了解一下](about.md)

</div>

## 这个站点

用 [MkDocs](https://www.mkdocs.org/) + [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) 搭的，
全文是 Markdown，`mkdocs build` 出来就是一堆静态文件，扔哪儿都能跑。

正文字体用的是[霞鹜文楷](https://github.com/lxgw/LxgwWenKai)，字体文件自托管，
不依赖任何外部 CDN，断网也能正常显示。

!!! tip "订阅"

    站点提供 RSS 订阅：[:fontawesome-solid-rss: feed_rss_created.xml]({{ config.site_url }}feed_rss_created.xml)。
    想按时间翻旧文，用左侧「博客 → 归档」。

## 最近更新

- [用 MkDocs Material 搭一个能长期写下去的博客](blog/posts/mkdocs-material-blog-setup.md)
- [pathlib 用了三年，我还是会写错这几处](blog/posts/pathlib-gotchas.md)
- [把 Git 别名重新整理了一遍](notes/tooling/git-aliases.md)
- [开篇：为什么又想起来写博客](blog/posts/hello-world.md)
