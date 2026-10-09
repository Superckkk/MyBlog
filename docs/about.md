# 关于

## 我是谁

浙江大学人工智能专业本科生。

## 关于这个站点

站点本身是一个 MkDocs 项目，源文件全是 Markdown，构建产物是纯静态文件。

| 部分 | 选型 |
| --- | --- |
| 静态站点生成 | [MkDocs](https://www.mkdocs.org/) |
| 主题 | [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) |
| 正文字体 | [霞鹜文楷 LXGW WenKai](https://github.com/lxgw/LxgwWenKai)（自托管 WOFF2 子集） |
| 等宽字体 | LXGW WenKai Mono |
| 搜索 | Material 内置搜索 + jieba 中文分词 |
| 数学公式 | MathJax 3（CDN） |
| 讲义阅读 | 浏览器内置 PDF 查看器（`<iframe>` 嵌入） |

字体没有走 Google Fonts，也没有走任何 CDN。`docs/assets/fonts/lxgw-wenkai/`
下面是一整套按 `unicode-range` 切好的 woff2 子集，浏览器只会拉当前页面用到的那几个。

唯一的外部依赖是数学公式用的 MathJax——自托管一套太占体积，
如果你更在意离线可用，把 `mkdocs.yml` 里 `extra_javascript` 那两行去掉即可，
代价是行内公式会显示成原始的 `$...$`。

## 联系我

- GitHub：[:fontawesome-brands-github: Superckkk](https://github.com/Superckkk)
- 站点仓库：[Superckkk/MyBlog](https://github.com/Superckkk/MyBlog)

## 版权

站点文字内容采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh)
许可，代码片段随便用。

霞鹜文楷以 [SIL Open Font License 1.1](https://openfontlicense.org/) 授权，
许可全文见 [`docs/assets/fonts/lxgw-wenkai/OFL.txt`](assets/fonts/lxgw-wenkai/OFL.txt)。
