import { $ } from "bun";
import figlet from "figlet";
import ora from "ora";
import chalk from "chalk";

figlet.text(
  "dotfiles",
  {
    font: "Avatar",
    horizontalLayout: "default",
    verticalLayout: "default",
    width: 80,
    whitespaceBreak: true,
  },
  function (err, data) {
    if (err) {
      console.log("Something went wrong...");
      console.dir(err);
      return;
    }
    console.log(data);
  }
);

const wait = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

await wait(1000);

console.log(chalk.yellow("⚠️ Building dotfiles...\n"));

const start = Date.now();

const readmeSpinner = ora("Building README.md").start();
try {
  const readmeBuildStart = Date.now();
  const res = await $`python3 tools/build_readme.py`.quiet();
  if (res.exitCode === 0)
    readmeSpinner.succeed(
      `Built README.md in ${Date.now() - readmeBuildStart}ms`
    );
  else
    readmeSpinner.fail(
      `Failed to build README.md in ${
        Date.now() - readmeBuildStart
      }ms - skipping`
    );
} catch (e) {
  readmeSpinner.fail("Failed to build README.md - skipping");
}

const brewSpinner = ora("Building brew_packages.txt").start();
try {
  const brewBuildStart = Date.now();
  const res = await $`brew list > brew_packages.txt`.quiet();
  if (res.exitCode === 0)
    brewSpinner.succeed(
      `Built brew_packages.txt in ${Date.now() - brewBuildStart}ms`
    );
  else brewSpinner.fail("Failed to build brew_packages.txt - skipping");
} catch (e) {
  brewSpinner.fail("Failed to build brew_packages.txt - skipping");
}

const gitStatusSpinner = ora("Checking for changes to commit").start();
try {
  await $`git add .`;
  const gitStatus = await $`git status`.text();
  if (!gitStatus.includes("Changes to be committed:")) {
    gitStatusSpinner.fail("No changes to commit found");
    console.log(chalk.red("\nUnable to commit, exiting..."));
    process.exit(0);
  } else {
    gitStatusSpinner.succeed("Changes to commit found");
  }
} catch (e) {
  gitStatusSpinner.fail("Failed to check for changes to commit");
}

const commitSpinner = ora("Committing changes").start();
try {
  const commitMesage = await $`python3 tools/commit_msg.py`.text();
  console.log(commitMesage);
  console.log(commitMesage);
  commitSpinner.succeed("Changes committed");
} catch (e) {
  commitSpinner.fail("Failed to commit changes");
}
process.exit(0);
const commitMesage = await $`python3 ~/.config/tools/commit_msg.py`.text();
await $`git commit -m ${commitMesage}`;

await $`git push origin main`;

await $`yabai --restart-service`;
await $`skhd --reload`;
await $`brew services restart sketchybar`;
