#!/usr/bin/env python3
import sys
from bs4 import BeautifulSoup

def fix_html(file_name):
    # Read the HTML content from the file
    with open(file_name, 'r') as file:
        html_content = file.read()

    # Parse the HTML
    soup = BeautifulSoup(html_content, 'html.parser')

    # Define tags to drop
    tags_to_drop = [ 'meta', 'link',  'a', 'img', 'svg', 'script']

    # Drop specified tags
    for tag in soup.find_all(tags_to_drop):
        try:
          tag.decompose()
        except:
          pass

    # Remove tags with id containing "menu"
    for tag in soup.find_all(id=lambda x: x and 'menu' in x):
        try:
          tag.decompose()
        except:
          pass

    # Drop tags with no text or image content
    for tag in soup.find_all():
        try:
          if not (tag.text.strip() or tag.find('img')):
            tag.decompose()
        except:
           pass

    # Use prettify to automatically fix and format the HTML
    fixed_html = soup.prettify()

    return fixed_html

if __name__ == "__main__":
    # Check if a file name is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python fixhtml.py <file_name>")
        sys.exit(1)

    file_name = sys.argv[1]
    fixed_html = fix_html(file_name)

    # Print the fixed HTML
    print(fixed_html)
