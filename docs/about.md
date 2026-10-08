---
render_macros: true
---

# 关于

## 我是谁

一个写后端和基础设施的工程师，平时和 Python、Go、Linux 打交道比较多。
这里放的是一些工作里绕不开、又值得记下来的东西。

## 关于这个站点

站点本身是一个 MkDocs 项目，源文件全是 Markdown，构建产物是纯静态文件。

| 部分 | 选型 |
| --- | --- |
| 静态站点生成 | [MkDocs](https://www.mkdocs.org/) |
| 主题 | [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) |
| 正文字体 | [霞鹜文楷 LXGW WenKai](https://github.com/lxgw/LxgwWenKai)（自托管 WOFF2 子集） |
| 等宽字体 | LXGW WenKai Mono |
| 搜索 | Material 内置搜索 + jieba 中文分词 |
| 订阅 | mkdocs-rss-plugin |

字体没有走 Google Fonts，也没有走任何 CDN。`docs/assets/fonts/lxgw-wenkai/`
下面是一整套按 `unicode-range` 切好的 woff2 子集，浏览器只会拉当前页面用到的那几个。

## 联系我

- GitHub：[:fontawesome-brands-github: your-name](https://github.com/your-name)
- 邮箱：[:fontawesome-solid-envelope: you@example.com](mailto:you@example.com)
- RSS：[:fontawesome-solid-rss: feed_rss_created.xml]({{ config.site_url }}feed_rss_created.xml)

## 版权

站点文字内容采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh)
许可，代码片段随便用。

霞鹜文楷以 [SIL Open Font License 1.1](https://openfontlicense.org/) 授权，
许可全文见 [`docs/assets/fonts/lxgw-wenkai/OFL.txt`](assets/fonts/lxgw-wenkai/OFL.txt)。
