import os
import re

keymap = {
    "0x29": "ñ",
    "0x2F": ".",
    "0x2B": ",",
    "0x2A": "ç",
    "0x27": "´",
    "0x14": "3",
}


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

        # Find the start of the keybinds section
        start = None
        for i, line in enumerate(lines):
            if line.startswith("## Keybinds"):
                start = i
                break

        # start from the end of the file backwards and remove all lines until the end of the keybinds section which will the the first line to start with "- <kbd>"
        end = len(lines)
        for i, line in reversed(list(enumerate(lines))):
            if line.startswith("- <kbd>"):
                end = i
                break

        # Remove the old keybinds section
        lines = lines[:start] + lines[end + 1 :]

        # Insert the new keybinds section
        lines.insert(start, "## Keybinds\n")
        start += 1
        for key, keybinds in keybinds.items():
            lines.insert(start, f"### {key} + ...\n")
            start += 1
            max_keybind_length = max(
                len(" + ".join(keybind["keybind"])) for keybind in keybinds
            )
            for keybind in keybinds:
                padding = max_keybind_length - len(" + ".join(keybind["keybind"]))
                lines.insert(
                    start,
                    f"- <kbd>{' + '.join(keybind['keybind'])}{' ' * padding}</kbd> : {keybind['action']}\n",
                )
                start += 1
            lines.insert(start, "\n")
            start += 1

    # Write the new readme file
    with open(os.path.expanduser("~/.config/README.md"), "w") as f:
        f.writelines(lines)

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
