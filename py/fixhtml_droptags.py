#!/usr/bin/env python3

import sys
from bs4 import BeautifulSoup

def fix_html(file_name):
    # Read the HTML content from the file
    with open(file_name, 'r') as file:
        html_content = file.read()

    # Parse the HTML
    soup = BeautifulSoup(html_content, 'html.parser')
    
    title_tag = soup.find('title')
    if title_tag:
       title_content = title_tag.get_text().strip()
    if not title_content:
       title_content = "No title tag found"

    # Define tags to drop
    #tags_to_drop = [ 'meta', 'link',  'a', 'img', 'svg', 'script']
    tags_to_drop = [ 'meta', 'link', 'svg', 'script' ,'button','link']

    # Drop specified tags
    for tag in soup.find_all(tags_to_drop):
        try:
          tag.decompose()
        except:
          pass

    # Find the first paragraph with at least ~ 2 lines 
    real_paragraph = None
    #for paragraph in soup.find_all():
     #  if len(paragraph.get_text(strip=True))>= 160:
      #      real_paragraph = paragraph
       #     break

    for paragraph in soup.find_all():

      if real_paragraph is None:
        text = paragraph.get_text(strip=True)
        scanlen = len(text) -159
        for i in range(scanlen):  
          if all(c != '<' for c in text[i:i+160]): 
             real_paragraph = paragraph
             break
          else:
             continue
          break
      else:
          break

    # If a real paragraph is found, remove all links before it
    if real_paragraph:
        h1_tag = soup.new_tag('h1')
        h1_tag.string = title_content.upper()
        real_paragraph.insert(0, h1_tag)

        backups = []
        current_element = real_paragraph.previous_element
        while current_element and current_element.name != 'body':
         #   if current_element.name in ['a', 'li','div','span']:
        #    if len(current_element.get_text(strip=True))>= 1:

            backups.append(current_element)
            current_element.extract()
            if hasattr(current_element, 'previous_element'):
              current_element = current_element.previous_element
            else: 
              current_element = None

        # Create a new title element for the removed content
        title_tag = soup.new_tag('h1')
        title_tag.string = 'atomique - small texts from above'

        # Append the removed content under the new title
        atend = soup.new_tag('p')
        atend.append(title_tag)
        for backup in backups:
            atend.append(backup)
        soup.body.append(atend)

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

# Find all link tags and replace them with the link text plus the link number
    links = soup.find_all('a')
    link_info = []
    for i, link in enumerate(links, 1):
        try:
          link_text = link.get_text()
          new_text = f'{link_text} <{i}>'
          link.replace_with(new_text)
          link_info.append((f'{i}', link.attrs['href']))
        except:
          pass 

    # Create an unordered list containing the links with their numbers and actual URLs
    h1_tag = soup.new_tag('h1')
    h1_tag.string = f'atomique - Collected links'
    soup.body.append(h1_tag)

    ul_tag = soup.new_tag('ul')
    for number, url in link_info:
       li_tag = soup.new_tag('li')
       li_tag.string = f'[{number}]({url})'
       ul_tag.append(li_tag)

    # Append the unordered list to the end of the HTML content
    soup.body.append(ul_tag)

    
    # Output modified HTML
    print(soup.prettify())



if __name__ == "__main__":
    # Check if a file name is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python fixhtml.py <file_name>")
        sys.exit(1)

    file_name = sys.argv[1]
    fix_html(file_name)

