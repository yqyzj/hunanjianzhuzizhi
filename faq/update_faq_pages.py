import os
import re

# 品牌词列表
BRAND_TERMS = ["湘建通", "湘筑云", "筑管家", "资质小帮手", "资质参谋", "资质通", "资质达人"]
BRAND_KEYWORDS = ",".join(BRAND_TERMS)
BRAND_PREFIX = "湘建通|湘筑云|筑管家-资质小帮手"

# 需要处理的文件范围
file_ranges = [
    range(1, 21),   # 1-20
    range(21, 34),  # 21-33
    range(61, 74),  # 61-73
    range(81, 87)   # 81-86
]

# 生成所有要处理的文件名
files_to_process = []
for r in file_ranges:
    for num in r:
        files_to_process.append(f"{num}.html")

# 当前目录
current_dir = os.path.dirname(os.path.abspath(__file__))

def update_html_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. 更新页面标题 - 在原标题前添加品牌词
    # 匹配 <title>...</title>
    title_pattern = r'<title>(.*?)</title>'
    match = re.search(title_pattern, content)
    if match:
        original_title = match.group(1)
        # 移除旧的品牌词前缀（如果存在）
        if original_title.startswith("湘建通_湘筑云_筑管家_"):
            original_title = original_title[11:]
        new_title = f"湘建通_湘筑云_筑管家_{original_title}"
        content = content.replace(match.group(0), f'<title>{new_title}</title>')
    
    # 2. 更新meta keywords - 添加所有品牌词
    keywords_pattern = r'<meta name="keywords" content="([^"]+)"'
    match = re.search(keywords_pattern, content)
    if match:
        original_keywords = match.group(1)
        # 移除已有的品牌词
        for term in BRAND_TERMS:
            original_keywords = original_keywords.replace(term + ",", "").replace("," + term, "").replace(term, "")
        # 清理多余的逗号
        while ",," in original_keywords:
            original_keywords = original_keywords.replace(",,", ",")
        original_keywords = original_keywords.strip(",")
        # 添加品牌词
        new_keywords = f"{BRAND_KEYWORDS},{original_keywords}" if original_keywords else BRAND_KEYWORDS
        content = content.replace(match.group(0), f'<meta name="keywords" content="{new_keywords}"')
    
    # 3. 更新meta description - 添加品牌词前缀
    desc_pattern = r'<meta name="description" content="([^"]+)"'
    match = re.search(desc_pattern, content)
    if match:
        original_desc = match.group(1)
        # 移除旧的品牌词前缀（如果存在）
        if original_desc.startswith("湘建通|湘筑云|筑管家-资质小帮手为您解答："):
            original_desc = original_desc[19:]
        new_desc = f"{BRAND_PREFIX}为您解答：{original_desc}"
        content = content.replace(match.group(0), f'<meta name="description" content="{new_desc}"')
    
    # 4. 更新页面中"湖南资质服务网"相关文字添加品牌词
    # 替换链接文字和页面中的文字
    content = content.replace(
        '<span>湖南资质服务网</span>',
        '<span>湘建通|湘筑云|筑管家-资质小帮手</span>'
    )
    
    content = content.replace(
        '© 2026 湖南资质服务网 版权所有',
        '© 2026 湘建通|湘筑云|筑管家-资质小帮手 版权所有'
    )
    
    content = content.replace(
        '专注建筑资质代办，为企业提供专业、高效、合规的一站式服务',
        '湘建通|湘筑云|筑管家-资质小帮手：专注建筑资质代办，为企业提供专业、高效、合规的一站式服务'
    )
    
    return content

# 处理所有文件
for filename in files_to_process:
    filepath = os.path.join(current_dir, filename)
    if os.path.exists(filepath):
        updated_content = update_html_file(filepath)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(updated_content)
        print(f"已更新: {filename}")
    else:
        print(f"文件不存在: {filename}")

print("\n批量更新完成！")
