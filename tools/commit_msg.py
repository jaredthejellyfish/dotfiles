from git import Repo
import difflib
from dotenv import load_dotenv
import os
import openai

load_dotenv()

openai.api_key = os.getenv("OPENAI_API_KEY")
current_path = os.getcwd()
repo = Repo(current_path)


def generate_message(diff: str) -> str:
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-16k",
        messages=[
            {
                "role": "system",
                "content": "You are a helpful assistant. You receive a diff of the current git repo the user is working on and then share a commit message based on all the information in the git diff.",
            },
            {
                "role": "user",
                "content": f"Make sure to only include a well formatted commit message in your response:\n{diff}",
            },
        ],
        temperature=0,
        max_tokens=2500,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
    )

    return response.choices[0].message.content


def print_diff(repo):
    diff_index = repo.index.diff("HEAD")
    output = []

    for diff_item in diff_index:
        if diff_item.change_type == "A":  # file added
            output.append(
                "--------------- ADDED: {} ---------------".format(diff_item.a_path)
            )
            b_blob_text = diff_item.b_blob.data_stream.read().decode("utf-8")
            output.append(b_blob_text)
            output.append("\n")
        elif diff_item.change_type == "M":  # file modified
            output.append(
                "--------------- MODIFIED: {} ---------------".format(diff_item.a_path)
            )
            a_blob_text = diff_item.a_blob.data_stream.read().decode("utf-8")
            b_blob_text = diff_item.b_blob.data_stream.read().decode("utf-8")
            output.extend(print_diff_lines(a_blob_text, b_blob_text))
            output.append("\n")
        elif diff_item.change_type == "D":  # file deleted
            output.append(
                "--------------- CREATED: {} ---------------".format(diff_item.a_path)
            )
            a_blob_text = diff_item.a_blob.data_stream.read().decode("utf-8")
            output.append(a_blob_text)
            output.append("\n")
        else:
            output.append(
                "--------------- UNKNOWN: {} ---------------".format(diff_item.a_path)
            )
            output.append("Unknown change type {}".format(diff_item.change_type))
            output.append("\n")

    return "\n".join(output)


def print_diff_lines(a_blob_text, b_blob_text):
    a_lines = a_blob_text.split("\n")
    b_lines = b_blob_text.split("\n")
    return list(difflib.unified_diff(a_lines, b_lines))


diff = print_diff(repo)

message = generate_message(diff)

if message.lower().find("Commit message".lower()) != -1:
    message = message[message.lower().find("Commit message".lower()) + 16 :]

print(message)
