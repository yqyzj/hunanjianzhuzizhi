# GitHub 推送经验记录

## 项目概述

**项目名称**: 湖南建筑资质网  
**仓库地址**: https://github.com/yqyzj/hunanjianzhuzizhi  
**创建日期**: 2026年5月25日  
**文件数量**: 59个文件（含首页和86个FAQ页面）

---

## 一、推送成功经验

### 1.1 成功操作步骤

| 步骤 | 命令 | 说明 |
|------|------|------|
| 初始化仓库 | `git init` | 在本地创建新仓库 |
| 添加远程地址 | `git remote add origin <url>` | 关联 GitHub 仓库 |
| 配置用户信息 | `git config user.name/user.email` | 设置提交者信息 |
| 添加文件 | `git add -A` | 追踪所有文件 |
| 提交 | `git commit -m "message"` | 本地提交 |
| 推送 | `git push -u origin main` | 推送到远程分支 |

### 1.2 成功要点

- ✅ **文件结构清晰**: 使用相对路径组织文件
- ✅ **.gitignore 配置**: 排除不必要的文件（laragon、node_modules 等）
- ✅ **编码处理**: 设置 `core.autocrlf false` 避免换行符问题
- ✅ **分支管理**: 使用 `main` 作为主分支（GitHub 新标准）

### 1.3 成功推送记录

```bash
# 首次推送成功
To https://github.com/yqyzj/hunanjianzhuzizhi.git
 * [new branch]      master -> master

# 分支迁移成功
To https://github.com/yqyzj/hunanjianzhuzizhi.git
 + c0df7df...ee21b0a main -> main (forced update)
```

---

## 二、推送失败经验与解决方案

### 2.1 失败类型汇总

| 错误类型 | 错误信息 | 原因 | 解决方案 |
|----------|----------|------|----------|
| 认证失败 | `Authentication failed` | 缺少 GitHub 凭证 | 使用 Personal Access Token |
| 网络超时 | `Connection was reset` | 网络不稳定 | 重试或使用代理 |
| DLL缺失 | `httpapi.dll not found` | 系统库问题 | 使用完整路径的 git |
| 分支冲突 | `rejected (fetch first)` | 远程有未同步代码 | 强制推送或合并 |
| 文件类型错误 | `faq` 被当作文件 | 目录复制问题 | 删除后重新复制目录 |

### 2.2 详细错误分析

#### 错误1: 认证失败
```bash
fatal: Authentication failed for 'https://github.com/yqyzj/hunanjianzhuzizhi.git/'
```
**解决方案**: 使用 GitHub Personal Access Token  
```bash
git remote set-url origin https://<token>@github.com/yqyzj/hunanjianzhuzizhi.git
```

#### 错误2: 网络连接失败
```bash
fatal: unable to access 'https://github.com/...': Recv failure: Connection was reset
```
**解决方案**: 
- 等待网络恢复后重试
- 配置代理（如果需要）
```bash
git config --global http.proxy http://proxy:port
git config --global https.proxy https://proxy:port
```

#### 错误3: 目录被当作文件
```bash
fatal: path 'faq/' exists on disk, but not in 'HEAD'
```
**解决方案**: 删除错误文件，重新复制目录
```bash
Remove-Item "faq" -Force
Copy-Item -Path "source/faq" -Destination "faq" -Recurse -Force
```

#### 错误4: 分支拒绝推送
```bash
! [rejected] main -> main (fetch first)
```
**解决方案**: 使用强制推送（确保本地代码是最新的）
```bash
git push -u origin main --force
```

---

## 三、最佳实践总结

### 3.1 推送前检查清单

- [ ] 确认 `.gitignore` 已正确配置
- [ ] 检查所有内链使用相对路径
- [ ] 确认文件编码统一（UTF-8）
- [ ] 测试网站在本地能正常运行
- [ ] 确认网络连接稳定

### 3.2 分支管理建议

1. **使用 `main` 作为主分支**: GitHub 已将默认分支名从 `master` 改为 `main`
2. **创建功能分支**: 开发新功能时创建独立分支
3. **定期同步**: 保持本地和远程分支同步

### 3.3 网络问题应对策略

| 场景 | 策略 |
|------|------|
| 临时网络波动 | 等待几分钟后重试 |
| 持续网络问题 | 配置代理或使用 SSH |
| TLS 验证警告 | 可临时关闭验证（不推荐长期使用） |

---

## 四、项目文件清单

```
hunanjianzhuzizhi/
├── index.html                    # 首页
├── github.md                     # 本文件
└── faq/
    ├── index.html               # FAQ索引页
    ├── 1.html ~ 33.html         # FAQ详情页
    ├── 61.html ~ 73.html        # FAQ详情页
    ├── 81.html ~ 86.html        # FAQ详情页
    └── *.py                     # 生成脚本
```

---

## 五、GitHub Pages 部署

### 5.1 启用步骤

1. 访问 GitHub 仓库 → Settings → Pages
2. Source 选择 `main` 分支
3. 点击 Save
4. 等待几分钟后访问: https://yqyzj.github.io/hunanjianzhuzizhi

### 5.2 自定义域名（可选）

如需使用自定义域名 `hunanjianzhuzizhi.yqes.cn`:
1. 在仓库根目录创建 `CNAME` 文件，内容为域名
2. 在域名服务商处配置 DNS 记录（CNAME 指向 `yqyzj.github.io`）

---

## 更新记录

| 日期 | 版本 | 说明 |
|------|------|------|
| 2026-05-25 | v1.0 | 首次推送，完成基础功能 |

---

*文档创建时间: 2026年5月25日*
