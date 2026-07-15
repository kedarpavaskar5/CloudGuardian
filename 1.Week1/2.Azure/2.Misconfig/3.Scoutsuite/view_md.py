import markdown
import sys
import os
import webbrowser

md_file = sys.argv[1]
html_file = md_file.replace('.md', '.html')

with open(md_file, 'r', encoding='utf-8') as f:
    text = f.read()

# Convert markdown to HTML
html = markdown.markdown(text, extensions=['tables', 'fenced_code'])

# Wrap in basic HTML structure with some nice CSS styling
full_html = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Markdown Preview</title>
    <style>
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
            background-color: #f8f9fa;
        }}
        .container {{
            background-color: white;
            padding: 2rem 4rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }}
        h1, h2, h3 {{ color: #2c3e50; border-bottom: 1px solid #eee; padding-bottom: 0.3em; }}
        code {{ background-color: #f1f1f1; padding: 2px 4px; border-radius: 4px; font-family: monospace; }}
        pre {{ background-color: #f1f1f1; padding: 1rem; border-radius: 4px; overflow-x: auto; }}
        img {{ max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-top: 1rem; }}
        table {{ border-collapse: collapse; width: 100%; margin-bottom: 1rem; }}
        th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
        th {{ background-color: #f4f6f8; }}
        blockquote {{ border-left: 4px solid #0366d6; margin: 0; padding-left: 1rem; color: #586069; }}
    </style>
</head>
<body>
    <div class="container">
        {html}
    </div>
</body>
</html>
"""

with open(html_file, 'w', encoding='utf-8') as f:
    f.write(full_html)

# Open in default browser
webbrowser.open('file://' + os.path.abspath(html_file))
