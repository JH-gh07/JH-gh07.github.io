# Hextra Theme Migration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Migrate Hugo blog from PaperMod theme to Hextra theme using Hugo Modules for a modern, Next.js-inspired design.

**Architecture:** Use Hugo Modules to import Hextra theme, update configuration for Hextra-specific settings, add proper Front Matter to all content files, and create necessary index pages for homepage and blog listing.

**Tech Stack:** Hugo 0.152.2, Hugo Modules, Hextra theme, Git

---

## Task 1: Prepare Git Branch

**Files:**
- Working directory: `/Users/oujiazhan/Desktop/博客/myblog`

**Step 1: Check current git status**

Run:
```bash
git status
```

Expected: Should show clean working directory or only `.vscode/` untracked files

**Step 2: Ensure on main branch**

Run:
```bash
git branch --show-current
```

Expected: Output should be `main`

**Step 3: Create feature branch**

Run:
```bash
git checkout -b hextra-theme
```

Expected: Output like "Switched to a new branch 'hextra-theme'"

**Step 4: Verify branch created**

Run:
```bash
git branch --show-current
```

Expected: Output should be `hextra-theme`

---

## Task 2: Initialize Hugo Modules

**Files:**
- Create: `go.mod` (will be created by Hugo)

**Step 1: Initialize Hugo module**

Run:
```bash
hugo mod init github.com/JH-gh07/myblog
```

Expected: Output like "go: creating new go.mod: module github.com/JH-gh07/myblog"

**Step 2: Verify go.mod created**

Run:
```bash
cat go.mod
```

Expected:
```
module github.com/JH-gh07/myblog

go 1.25
```

**Step 3: Commit module initialization**

Run:
```bash
git add go.mod
git commit -m "build: initialize Hugo modules

- Initialize go.mod for Hugo Modules support
- Prepare for Hextra theme installation

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 3: Update hugo.yaml Configuration

**Files:**
- Modify: `/Users/oujiazhan/Desktop/博客/myblog/hugo.yaml`

**Step 1: Backup current configuration**

Run:
```bash
cp hugo.yaml hugo.yaml.papermod.bak
```

Expected: Backup file created

**Step 2: Replace hugo.yaml content**

Replace entire content of `hugo.yaml` with:

```yaml
baseURL: "https://JH-gh07.github.io/"
languageCode: "zh-cn"
title: "我的博客"

# Hugo Modules - Import Hextra theme
module:
  imports:
    - path: github.com/imfing/hextra

# Markup configuration for Hextra
markup:
  goldmark:
    renderer:
      unsafe: true  # Allow raw HTML in markdown
  highlight:
    noClasses: false  # Enable syntax highlighting

# Menu configuration
menu:
  main:
    - name: Blog
      pageRef: /posts
      weight: 1
    - name: Archives
      pageRef: /archives
      weight: 2
    - name: Tags
      pageRef: /tags
      weight: 3
    - name: Search
      weight: 4
      params:
        type: search

# Keep existing configurations
enableRobotsTXT: true

pagination:
  pagerSize: 10

# Hugo build cache
caches:
  images:
    dir: ":cacheDir/images"

# Hextra parameters
params:
  description: "边学习，边记录，边分享。"

  # Navbar settings
  navbar:
    displayTitle: true
    displayLogo: false

  # Footer settings
  footer:
    displayCopyright: true
    displayPoweredBy: false
```

**Step 3: Verify syntax**

Run:
```bash
cat hugo.yaml | head -20
```

Expected: Should display first 20 lines without errors

**Step 4: Download Hextra module**

Run:
```bash
hugo mod get -u
```

Expected: Output showing Hextra being downloaded, like:
```
go: downloading github.com/imfing/hextra v...
```

**Step 5: Verify go.sum created**

Run:
```bash
ls -la go.sum
```

Expected: File exists

**Step 6: Commit configuration changes**

Run:
```bash
git add hugo.yaml go.sum
git commit -m "feat: configure Hextra theme via Hugo Modules

- Replace PaperMod theme with Hextra using Hugo Modules
- Update markup configuration for Hextra requirements
- Configure menu with Blog, Archives, Tags, and Search
- Add Hextra-specific parameters

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 4: Add Front Matter to Existing Blog Post

**Files:**
- Modify: `/Users/oujiazhan/Desktop/博客/myblog/content/posts/PaperInsight.md`

**Step 1: Read current file**

Run:
```bash
head -5 content/posts/PaperInsight.md
```

Expected: Shows "# 深夜有感——关于论文构思..." without front matter

**Step 2: Add Front Matter**

Add the following Front Matter block at the very beginning of the file, BEFORE the existing content:

```markdown
---
title: "深夜有感——关于论文构思idea的时候该如何进行细化"
date: 2024-12-18
draft: false
tags: ["论文", "研究方法", "学术写作"]
description: "论文构思的三个细化层次：整体结构层面、论证逻辑层面、写作执行层面"
---

```

**Step 3: Remove the markdown title**

Remove the first line `# 深夜有感——关于论文构思idea的时候该如何进行细化` since the title is now in Front Matter.

The file should start like:
```markdown
---
title: "深夜有感——关于论文构思idea的时候该如何进行细化"
date: 2024-12-18
draft: false
tags: ["论文", "研究方法", "学术写作"]
description: "论文构思的三个细化层次：整体结构层面、论证逻辑层面、写作执行层面"
---

三个层次：
1）整体结构层面；2）论证逻辑层面；3）写作执行层面。
> 虽然这整体是ai构思出来的...
```

**Step 4: Verify front matter added**

Run:
```bash
head -10 content/posts/PaperInsight.md
```

Expected: Shows YAML front matter block at top

**Step 5: Commit changes**

Run:
```bash
git add content/posts/PaperInsight.md
git commit -m "refactor: add front matter to blog post

- Add YAML front matter with title, date, tags, description
- Remove duplicate markdown title
- Prepare content for Hextra theme

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 5: Create Homepage Index

**Files:**
- Create: `/Users/oujiazhan/Desktop/博客/myblog/content/_index.md`

**Step 1: Create _index.md file**

Create file with content:

```markdown
---
title: 这里是cAIog博客
layout: hextra-home
---

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-subtitle >}}
  边学习，边记录，边分享。
{{< /hextra/hero-subtitle >}}
</div>

<div class="hx-mb-12">
{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    title="博客文章"
    subtitle="记录学习和思考的过程"
    link="/posts"
  >}}
  {{< hextra/feature-card
    title="标签分类"
    subtitle="按主题浏览内容"
    link="/tags"
  >}}
  {{< hextra/feature-card
    title="归档"
    subtitle="按时间查看所有文章"
    link="/archives"
  >}}
{{< /hextra/feature-grid >}}
</div>
```

**Step 2: Verify file created**

Run:
```bash
cat content/_index.md
```

Expected: Shows the content above

**Step 3: Commit homepage**

Run:
```bash
git add content/_index.md
git commit -m "feat: create homepage with Hextra layout

- Add homepage with hero section
- Include feature cards for navigation
- Use Hextra shortcodes for styling

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 6: Create Blog Listing Index

**Files:**
- Create: `/Users/oujiazhan/Desktop/博客/myblog/content/posts/_index.md`

**Step 1: Create posts/_index.md file**

Create file with content:

```markdown
---
title: Blog
cascade:
  type: blog
---

这里是所有博客文章的列表。
```

**Step 2: Verify file created**

Run:
```bash
cat content/posts/_index.md
```

Expected: Shows the content above

**Step 3: Commit blog listing page**

Run:
```bash
git add content/posts/_index.md
git commit -m "feat: create blog listing page

- Add posts index with cascade type
- Configure section for blog layout

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

Expected: Commit successful

---

## Task 7: Verify Hugo Build

**Files:**
- Output: `public/` directory (temporary, not committed)

**Step 1: Clean previous build**

Run:
```bash
rm -rf public/
```

Expected: public directory removed

**Step 2: Build site**

Run:
```bash
hugo --gc --minify
```

Expected: Build completes successfully with output like:
```
Start building sites …
...
Total in 123 ms
```

Should see NO ERROR messages. WARN messages are acceptable.

**Step 3: Verify public directory created**

Run:
```bash
ls -la public/ | head -10
```

Expected: Shows files like index.html, posts/, etc.

**Step 4: Check index.html exists**

Run:
```bash
ls -la public/index.html
```

Expected: File exists with non-zero size

---

## Task 8: Test Local Server

**Files:**
- None (testing only)

**Step 1: Start Hugo server**

Run:
```bash
hugo server -D
```

Expected: Server starts with output like:
```
Web Server is available at http://localhost:1313/
```

**Step 2: Verify in browser**

Manual test checklist:
- [ ] Visit http://localhost:1313/ - homepage loads
- [ ] Check homepage shows "这里是cAIog博客"
- [ ] Click "Blog" in navigation
- [ ] Verify blog post appears in listing
- [ ] Click on blog post
- [ ] Verify article content displays correctly
- [ ] Check dark/light mode toggle works
- [ ] Verify navigation menu is functional

**Step 3: Stop server**

Press `Ctrl+C` in terminal

Expected: Server stops gracefully

---

## Task 9: Push Branch to Remote

**Files:**
- None (git operation)

**Step 1: Review all changes**

Run:
```bash
git log --oneline -10
```

Expected: Shows all commits made in this session

**Step 2: Check git status**

Run:
```bash
git status
```

Expected: "On branch hextra-theme" with working directory clean (except possibly .vscode/)

**Step 3: Push branch to remote**

Run:
```bash
git push -u origin hextra-theme
```

Expected: Branch pushed successfully

**Step 4: Display branch URL**

Run:
```bash
echo "Branch pushed to: https://github.com/JH-gh07/myblog/tree/hextra-theme"
```

Expected: URL displayed for user to review changes on GitHub

---

## Verification Checklist

After completing all tasks, verify:

**Local Testing:**
- [ ] `hugo` command builds without errors
- [ ] `hugo server` starts successfully
- [ ] Homepage displays correctly at http://localhost:1313/
- [ ] Blog listing shows articles
- [ ] Individual blog posts display with correct formatting
- [ ] Dark/light mode toggle works
- [ ] Navigation menu is functional
- [ ] All links work (Blog, Archives, Tags)
- [ ] Mobile responsive design works (resize browser)
- [ ] Code blocks have syntax highlighting

**Git Status:**
- [ ] All changes committed
- [ ] Branch pushed to remote
- [ ] No uncommitted changes (except .vscode/)
- [ ] Commit messages follow convention

**Files Modified/Created:**
- [ ] go.mod created
- [ ] go.sum created
- [ ] hugo.yaml updated
- [ ] content/posts/PaperInsight.md has front matter
- [ ] content/_index.md created
- [ ] content/posts/_index.md created

---

## Next Steps

After successful implementation and testing:

1. **Merge to main** (if satisfied with results):
   ```bash
   git checkout main
   git merge hextra-theme
   git push origin main
   ```

2. **GitHub Actions** will automatically deploy to GitHub Pages

3. **Verify production** at https://JH-gh07.github.io/

4. **Optional cleanup**:
   ```bash
   git branch -d hextra-theme
   git push origin --delete hextra-theme
   rm -rf themes/PaperMod
   ```

---

## Rollback Plan

If anything goes wrong:

**Before merge:**
```bash
git checkout main
git branch -D hextra-theme
```

**After merge:**
```bash
git revert HEAD
git push origin main
```

---

## Troubleshooting

**Issue: hugo mod get fails**
- Solution: Ensure Go is installed: `go version`
- Run: `go mod tidy`

**Issue: Build errors about missing templates**
- Solution: Clear Hugo cache: `hugo mod clean`
- Retry: `hugo mod get -u`

**Issue: Dark mode not working**
- Solution: Check browser console for JS errors
- Clear browser cache and reload

**Issue: Blog posts not showing**
- Solution: Check front matter syntax is valid YAML
- Ensure `draft: false` in front matter

**Issue: Chinese characters display wrong**
- Solution: Verify `languageCode: "zh-cn"` in hugo.yaml
- Check file encoding is UTF-8
