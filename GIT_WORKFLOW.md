# Git 协作写作流程

## 分支策略

```
main (受保护分支，只接受 PR 合并)
  │
  ├── ch01-first-draft (第1章初稿分支)
  ├── ch01-revision (第1章修订分支)
  ├── ch02-first-draft (第2章初稿分支)
  └── ...
```

### 分支命名规范

| 类型 | 命名格式 | 示例 |
|:---|:---|:---|
| 初稿 | `chXX-first-draft` | `ch01-first-draft` |
| 修订 | `chXX-revision-N` | `ch01-revision-1` |
| 审核修改 | `chXX-review-fix` | `ch01-review-fix` |
| 附录 | `appendix-NAME` | `appendix-tools` |

---

## 完整写作流程

### 阶段1：准备（你发起）

```bash
# 1. 确保本地 main 是最新
git checkout main
git pull origin main

# 2. 创建写作分支
git checkout -b ch01-first-draft

# 3. 创建章节文件
touch chapters/part1-fundamentals/ch01.md
```

**你需要做的**：
- 创建分支
- 告诉我开始写哪一章
- 提供该章需要的特殊要求（如重点案例、特定数据来源）

---

### 阶段2：我写作（我完成）

我在 `ch01-first-draft` 分支上写作，提交规范：

```bash
# 写作中阶段性提交
git add chapters/part1-fundamentals/ch01.md
git commit -m "ch01: 完成开篇与理论部分

- 添加历史演进分析
- 补充GitHub Copilot 2024数据
- 待完成：前沿趋势、实践工具"

# 写作完成，标记为草稿完成
git add .
git commit -m "ch01: 初稿完成，待审核

- 完成全部5个部分
- 包含2个实践工具、1个案例
- 字数：约8000字"
```

**我的提交信息格式**：
```
chXX: 动作描述

- 具体完成内容1
- 具体完成内容2
- 状态说明"
```

---

### 阶段3：提交 PR（你发起）

```bash
# 1. 推送分支到远程
git push origin ch01-first-draft

# 2. 在 GitHub 创建 PR
# 标题：[审核] 第1章：AI时代的软件工程变革
# 描述：简要说明完成内容

# 3. 分配审阅者（你自己）
```

**PR 模板**：
```markdown
## 章节
第1章：AI时代的软件工程变革

## 完成内容
- [x] 开篇（2页）
- [x] 理论解析（5页）
- [x] 实践工具（3页）
- [x] 案例分析（3页）
- [x] 本章小结（1页）

## 统计数据
- 字数：约8000字
- 代码示例：0个
- 图表：1个

## 待确认
- [ ] 数据准确性（GitHub Copilot 2024报告）
- [ ] 案例是否符合预期
- [ ] 语气风格是否合适
```

---

### 阶段4：你审核（你完成）

#### 审核清单

**内容审核**（必须）：
- [ ] 事实数据准确（有来源）
- [ ] 案例真实可信
- [ ] 观点明确有支撑
- [ ] 无版权问题

**结构审核**（必须）：
- [ ] 符合每章标准结构
- [ ] 各部分比例合理（实践工具占50%+）
- [ ] 小结与内容一致

**语言审核**（必须）：
- [ ] 无 AI 套话（"值得注意的是"、"让我们来看"）
- [ ] 无空洞赞美
- [ ] 有棱角的判断（不是"取决于场景"）
- [ ] 语气专业但不学究

**技术审核**（视章节）：
- [ ] 代码可运行
- [ ] 工具命令正确
- [ ] 配置格式正确

#### 审核方式

**方式A：直接修改（小问题）**
```bash
# 你在 PR 上直接修改
git checkout ch01-first-draft
# 编辑文件
git commit -am "ch01: 审核修复-修正数据引用"
git push
```

**方式B：评论反馈（中等问题）**
在 PR 的 Files changed 页面，对具体行添加评论：
```
> 这段数据需要更新来源，GitHub 2024报告可能有新版本

建议：查一下最新数据
```

**方式C：打回修订（大问题）**
在 PR 评论中：
```markdown
## 审核结果：需要修订

### 主要问题
1. **结构问题**：实践工具部分占比不足30%，需要扩充
2. **内容问题**：前沿趋势缺少具体工具对比
3. **语言问题**：第3段有"值得注意的是"套话

### 建议修改
- 补充 Cursor vs Copilot 的实测对比
- 删除或改写套话
- 增加一个完整的案例

### 下一步
我将创建 `ch01-revision-1` 分支进行修改。
```

---

### 阶段5：修订（我完成）

如果需要修订：

```bash
# 基于原分支创建修订分支
git checkout ch01-first-draft
git checkout -b ch01-revision-1

# 修改后提交
git commit -am "ch01: 修订1-补充工具对比、删除套话

- 添加 Cursor vs Copilot 实测对比（2页）
- 删除3处套话表达
- 补充案例：某团队转型故事"

# 推送并更新 PR
git push origin ch01-revision-1
```

---

### 阶段6：合并（你完成）

审核通过后：

```bash
# 你在 GitHub 点击 "Merge pull request"
# 使用 Squash Merge，保持 main 分支整洁

# 合并后删除分支
git push origin --delete ch01-first-draft

# 本地清理
git checkout main
git pull origin main
git branch -d ch01-first-draft
```

**合并后更新 README**：
```markdown
- [x] **第1章**：AI时代的软件工程变革
```

---

## 协作节奏

### 写作顺序

**严格单线程，一章一章来**：
1. 第1章初稿 → 审核 → 修订 → 合并
2. 第2章初稿 → 审核 → 修订 → 合并
3. ...

**为什么单线程**：
- 避免内容冲突（前后章引用）
- 保证风格一致（前一章的反馈应用到后一章）
- 减少分支管理复杂度

### 时间预期

| 环节 | 预期时间 | 负责 |
|:---|:---:|:---:|
| 我写作 | 2-3天 | 我 |
| 你审核 | 1-2天 | 你 |
| 我修订 | 1天 | 我 |
| 合并 | 即时 | 你 |
| **单章周期** | **4-6天** | - |

**全书预期**：26章 × 5天 = 130天 ≈ 4.5个月（不含附录）

---

## 质量门禁

### 合格的定义

**必须全部满足**：
- [ ] 通过内容审核（事实准确）
- [ ] 通过结构审核（符合模板）
- [ ] 通过语言审核（无套话、有观点）
- [ ] 你主观认可（"这章可以了"）

**禁止合并的情况**：
- 有事实错误未修正
- 套话超过3处
- 实践部分不足50%
- 案例缺失或不真实

---

## 紧急修改流程

已合并到 main 后发现错误：

```bash
# 创建热修复分支
git checkout main
git checkout -b hotfix-ch01-data-error

# 修改
git commit -am "ch01: 修复数据错误-更新GitHub报告引用"

# PR → 快速审核 → 合并
```

**热修复标准**：不影响其他章节的小错误（数据、链接、错别字）

---

## 工具配置建议

### Git 钩子（可选）

`.git/hooks/pre-commit`：
```bash
#!/bin/bash
# 禁止提交到 main
current_branch=$(git symbolic-ref --short HEAD)
if [ "$current_branch" = "main" ]; then
    echo "禁止直接提交到 main 分支，请创建 PR"
    exit 1
fi
```

### GitHub 设置

1. **分支保护**：
   - Settings → Branches → Add rule
   - Branch name pattern: `main`
   - 勾选 "Require pull request reviews before merging"
   - 勾选 "Require status checks to pass"

2. **PR 模板**：
   创建 `.github/pull_request_template.md`

---

## 总结流程图

```
你：创建分支 ──→ 我：写作 ──→ 我：提交PR ──→ 你：审核
                                          ↓
你：合并 ←── 我：修订 ←── 你：反馈 ←─────┘
  ↓
你：更新README ──→ 下一章
```

**关键原则**：
- 一章一章来，不并行
- 每章必须经过审核才能合并
- 小问题直接修，大问题打回
- 保持 main 分支永远是"已完成且审核通过"的内容
