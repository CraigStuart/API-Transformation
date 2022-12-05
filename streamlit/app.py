import pandas as pd
import streamlit as st
from src.config.sqs_execution import sqs_main

def run():

    from PIL import Image
    image = Image.open(r'./src/assets/deloitte-logo-white.png')

    st.image(image, channels="RGB", output_format="auto")

    st.title("Text find and replace function")

    text_body = st.text_input("Enter your Full text", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                  on_change=None,label_visibility="visible")

    text_find = st.text_input("Enter the text you want to find and replace", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                  on_change=None,label_visibility="visible")

    text_replace = st.text_input("Enter your new text to 'replace with'", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                 on_change=None, label_visibility="visible")

    body = {
        "find": str(text_find),
        "replace": str(text_replace),
        "body": str(text_body)
    }

    if text_replace and text_find and text_body:
        if st.button("Submit request"):
            response = sqs_main(body)
            st.success('The transformed text is {}'.format(response))

            st.text_area(label="Results:", value=response)

if __name__ == '__main__':
    run()
