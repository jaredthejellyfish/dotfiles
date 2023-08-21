import os
import re
import openai
from dotenv import load_dotenv

load_dotenv()

openai.api_key = os.getenv("OPENAI_API_KEY")

keymap = {
    "0x29": "ñ",
    "0x2F": ".",
    "0x2B": ",",
    "0x2A": "ç",
    "0x27": "´",
    "0x14": "3",
}

sample_keybinds = """## Keybinds

### Application Shortcuts

- <kbd>alt + b</kbd> : Open Brave Browser
- <kbd>alt + v</kbd> : Open Visual Studio Code
- <kbd>alt + s</kbd> : Open Spotify

### Window Navigation

#### Switching Focus

- <kbd>cmd + alt + p</kbd> : Switch focus to window below
- <kbd>cmd + alt + o</kbd> : Switch focus to window above
- <kbd>cmd + alt + ñ</kbd> : Switch focus to previous monitor
- <kbd>cmd + alt + l</kbd> : Switch focus to window on the right
- <kbd>cmd + alt + k</kbd> : Switch focus to window on the left
- <kbd>cmd + alt + ç</kbd> : Switch focus to next space
- <kbd>cmd + alt + ´</kbd> : Switch focus to previous space

#### Window Manipulation

- <kbd>cmd + alt + h</kbd> : Warp focused window to the left
- <kbd>cmd + alt + j</kbd> : Warp focused window to the bottom
- <kbd>cmd + alt + m</kbd> : Rotate space 180 degrees and retain focused window
- <kbd>cmd + alt + n</kbd> : Swap focused window with window under mouse
- <kbd>cmd + alt + c</kbd> : Center window on screen and float it
- <kbd>cmd + alt + f</kbd> : Toggle float on focused window

### Space Management

- <kbd>cmd + alt + .</kbd> : Balance space windows
- <kbd>cmd + alt + ,</kbd> : Mirror current space along the y-axis
- <kbd>cmd + alt + x</kbd> : Toggle padding and gap on current space"""


def generate_keybinds_section(keybinds: dict):
    prompt = "\n".join(keybinds)

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {
                "role": "system",
                "content": "You are a helpful assistant that is trained to rewrite pieces of text. You only respond with the answer you were asked for. You provide no context or do anything you are not directly told to do. You are extremely good at categorizing, you are very granular and detailed in your categorizations. ",
            },
            {
                "role": "user",
                "content": f"I am going to give you a piece of markdown text with all the keybinds running on my computer at the moment, I want you to split the keybinds into categories and subcategories so I can then place that as a section into my README.md file.\n\n{prompt}",
            },
        ],
        temperature=0,
        max_tokens=3050,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
    )

    return response.choices[0].message.content


def print_keys(keybinds: dict):
    # Print the keybinds in Markdown format
    print("## Keybinds")
    for key, keybinds in keybinds.items():
        print(f"### {key} + ...")
        max_keybind_length = max(
            len(" + ".join(keybind["keybind"])) for keybind in keybinds
        )
        for keybind in keybinds:
            padding = max_keybind_length - len(" + ".join(keybind["keybind"]))
            print(
                f"- <kbd>{' + '.join(keybind['keybind'])}{' ' * padding}</kbd> : {keybind['action']}",
            )
        print("## keybinds")


def write_to_readme(keybinds: dict):
    # Open the readme file
    with open(os.path.expanduser("~/.config/README.md"), "r") as f:
        lines = f.readlines()

        print(len(lines))

        # Find the start of the keybinds section
        start = None
        for i, line in enumerate(lines):
            if line.startswith("## Keybinds"):
                start = i
                break

        # start from the end of the file backwards and remove all lines until the end of the keybinds section which will the the first line to start with "- <kbd>"
        end = len(lines)
        for i, line in reversed(list(enumerate(lines))):
            if line.find("- <kbd>"):
                end = i
                break

        # Remove the old keybinds section
        lines_start = lines[:start]
        lines_end = lines[end - (start -1) :]

        keybinds_list = []

        # Insert the new keybinds section
        keybinds_list.insert(start, "## Keybinds\n")
        start += 1
        for _, keybinds in keybinds.items():
            start += 1
            max_keybind_length = max(
                len(" + ".join(keybind["keybind"])) for keybind in keybinds
            )
            for keybind in keybinds:
                padding = max_keybind_length - len(" + ".join(keybind["keybind"]))
                keybinds_list.insert(
                    start,
                    f"- <kbd>{' + '.join(keybind['keybind'])}{' ' * padding}</kbd> : {keybind['action']}\n",
                )
                start += 1
            start += 1

    keybinds_section = generate_keybinds_section(keybinds_list)
    with open(os.path.expanduser("~/.config/README.md"), "w") as f:
        f.writelines(lines_start)

        f.write(keybinds_section)
        f.writelines(["\n"] + lines_end)

# Open the skhdrc file
with open(os.path.expanduser("~/.config/skhd/skhdrc"), "r") as f:
    lines = f.readlines()
    # Remove empty lines and comments
    lines = [
        {
            "keybind": re.split(r"\s*[+-]\s*", line.split(":")[0]),
            "action": line.split("#")[-1].strip(),
        }
        for line in lines
        if line.strip() and not line.startswith("#")
    ]

    # Replace key names with their corresponding values from the keymap
    for entry in lines:
        for i, key in enumerate(entry["keybind"]):
            if key in keymap:
                entry["keybind"][i] = keymap[key]

    # Sort the keybinds by their first key
    lines = sorted(lines, key=lambda x: x["keybind"][0])

    # Group the keybinds by their first key

    keybinds = {}
    for entry in lines:
        key = entry["keybind"][0]
        if key not in keybinds:
            keybinds[key] = []
        keybinds[key].append(entry)

    # print_keys(keybinds)
    write_to_readme(keybinds)
