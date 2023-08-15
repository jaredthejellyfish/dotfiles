#!python3
import json
import subprocess
import shlex


class Clipboard:
    def __init__(self, file: str) -> None:
        self.file = "/tmp/" + file
        try:
            with open(self.file, "r") as openfile:
                json_object = json.load(openfile)
        except:
            json_object = {"clipboard": []}
        self.storage = json_object

    def write_to_clipboard(self) -> None:
        json_object = json.dumps(self.storage, indent=4)
        with open(self.file, "w") as outfile:
            outfile.write(json_object)

    def add_to_clipboard(self) -> bool:
        clip = subprocess.check_output("pbpaste").decode("utf-8").strip()
        if clip not in self.storage["clipboard"]:
            if len(self.storage["clipboard"]) < 5:
                self.storage["clipboard"].append(clip)
            else:
                self.storage["clipboard"].pop(0)
                self.storage["clipboard"].append(clip)
            return True
        return False


if __name__ == "__main__":
    clipboard = Clipboard("clipboard_storage.json")
    if clipboardHasChanged := clipboard.add_to_clipboard():
        clipboard.write_to_clipboard()
