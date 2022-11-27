import streamlit as st
import pandas as pd
import numpy as np
from src.config.producer import send_sqs_message
import json

def run():

    from PIL import Image
    image = Image.open(r'./src/assets/deloitte-logo-white.png')

    st.image(image, channels="RGB", output_format="auto")

    add_selectbox = st.sidebar.selectbox(
    "How would you like to submit your text?",
    ("Online"))
    # ("Online", "Batch"))

    st.title("Text find and replace function")

    if add_selectbox == 'Online':

        text_body = st.text_input("Full text", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                      on_change=None,label_visibility="visible")

        text_find = st.text_input("Text you want to find", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                      on_change=None,label_visibility="visible")

        text_replace = st.text_input("Text you want to replace", value="", max_chars=None, key=None, type="default", help=None, autocomplete=None,
                     on_change=None, label_visibility="visible")

        body = {
            "find": text_find,
            "replace": text_replace,
            "body": text_body
        }

        if text_replace and text_find and text_body:
            if st.button("Submit request"):
                response_output = send_sqs_message([body])
                st.success('The transformed text is {}'.format(response_output))

    if add_selectbox == 'Batch':

        file_upload = st.file_uploader("Upload csv file to run the text transformations", type=["csv"])
        print(file_upload)

if __name__ == '__main__':
    run()