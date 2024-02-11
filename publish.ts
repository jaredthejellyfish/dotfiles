import { $ } from "bun";

await $`python3 tools/build_readme.py`;

await $`brew list > brew_packages.txt`;

await $`git add .`;

await $`git stage .`;

const commitMesage = await $`python3 ~/.config/tools/commit_msg.py`.text();
await $`git commit -m ${commitMesage}`;

await $`git push origin main`;

$`yabai --restart-service`;
$`skhd --reload`;
$`brew services restart sketchybar`;
