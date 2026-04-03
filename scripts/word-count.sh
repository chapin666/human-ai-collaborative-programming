#!/bin/bash
# 统计书籍字数

echo "========================================"
echo "《人机协作编程》字数统计"
echo "========================================"
echo ""

# 统计大纲字数
OUTLINE_WORDS=$(wc -m outline/*.md 2>/dev/null | tail -1 | awk '{print $1}')
echo "大纲字数: $OUTLINE_WORDS"

# 统计章节字数
CHAPTER_WORDS=0
for dir in chapters/*/; do
    if [ -d "$dir" ]; then
        dir_words=$(find "$dir" -name "*.md" -exec wc -m {} + 2>/dev/null | tail -1 | awk '{print $1}')
        if [ -n "$dir_words" ]; then
            CHAPTER_WORDS=$((CHAPTER_WORDS + dir_words))
            echo "$(basename $dir): $dir_words 字"
        fi
    fi
done

# 统计参考文献
REF_WORDS=$(wc -m references/*.md 2>/dev/null | tail -1 | awk '{print $1}')
echo "参考文献: ${REF_WORDS:-0} 字"

# 总计
TOTAL=$((OUTLINE_WORDS + CHAPTER_WORDS + ${REF_WORDS:-0}))

echo ""
echo "----------------------------------------"
echo "总计: $TOTAL 字符"
echo "预估汉字数: $((TOTAL / 2)) 字"
echo "========================================"
