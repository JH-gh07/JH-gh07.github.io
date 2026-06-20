# Wechatsync 本地发布

本项目使用本地 Wechatsync CLI，将一篇 Markdown 文章保存到多个平台的草稿箱。

## 首次配置

1. 安装 [Wechatsync Chrome 扩展](https://www.wechatsync.com/#install)。
2. 在浏览器中登录需要同步的平台。
3. 打开扩展设置，启用「MCP 连接」或「同步桥接」，并获取 Token。
4. 创建本机配置并填写 Token：

   ```bash
   cp .env.wechatsync.example .env.wechatsync
   ```

5. 在 `.env.wechatsync` 的 `WECHATSYNC_PLATFORMS` 中填写默认目标平台。
6. 检查浏览器中的平台登录状态：

   ```bash
   npm run sync:check
   ```

Token 仅保存在被 Git 忽略的 `.env.wechatsync`，不要提交或分享它。

## 同步文章

使用 `.env.wechatsync` 中配置的默认平台：

```bash
npm run sync -- content/posts/PaperInsight.md
```

临时覆盖目标平台：

```bash
npm run sync -- content/posts/PaperInsight.md --platforms zhihu,juejin
```

只解析和预览，不实际写入草稿箱：

```bash
npm run sync -- content/posts/PaperInsight.md --dry-run
```

Wechatsync 默认保存为草稿。同步后请到各平台检查排版、封面和分类，再手动发布。

## 平台 ID

常用平台 ID：`weixin`、`zhihu`、`juejin`、`csdn`、`jianshu`、`toutiao`、`bilibili`、`yuque`、`cnblogs`、`segmentfault`、`wordpress`。

查看 CLI 支持的平台：

```bash
npx wechatsync platforms
```
