// MathJax 3 配置
// 引擎本体在 mkdocs.yml 的 extra_javascript 里通过 CDN 引入。
//
// processHtmlClass 让 MathJax 只处理 pymdownx.arithmatex 生成的 .arithmatex 块，
// 避免误伤正文里出现的普通 $ 符号。
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

// 配合 Material 的 instant loading：整页加载完再排版一次
document$.subscribe(() => {
  MathJax.startup.output.clearCache();
  MathJax.typesetClear();
  MathJax.texReset();
  MathJax.typesetPromise();
});
