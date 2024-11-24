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
  const res = await $`source venv/bin/activate && python3 tools/build_readme.py`.quiet();
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

let commitMessage: string = "--no-commit-message-provided--";
const commitMessageSpinner = ora("Generating commit message").start();
try {
  const commitMessageStart = Date.now();
  commitMessage = await $`source venv/bin/activate && python3 tools/commit_msg.py`.text();
  commitMessageSpinner.succeed(`Generated commit message in ${Date.now() - commitMessageStart}ms`);
} catch (e) {
  commitMessageSpinner.fail("Failed to generate commit message");
}

const commitSpinner = ora("Committing changes").start();
try {
  const commitStart = Date.now();
  const res = await $`git commit -m ${commitMessage.replace("```", "")}`.quiet();
  if (res.exitCode === 0)
    commitSpinner.succeed(`Committed changes in ${Date.now() - commitStart}ms`);
  else commitSpinner.fail("Failed to commit changes");
} catch (e) {
  commitSpinner.fail("Failed to commit changes");
}

const pushSpinner = ora("Pushing changes").start();
try {
  const pushStart = Date.now();
  const res = await $`git push origin main`.quiet();
  if (res.exitCode === 0)
    pushSpinner.succeed(`Pushed changes in ${Date.now() - pushStart}ms`);
  else pushSpinner.fail("Failed to push changes");
} catch (e) {
  pushSpinner.fail("Failed to push changes");
}

const restartSpinner = ora("Restarting services").start();
try {
  const restartStart = Date.now();
  const yabaiRes = await $`yabai --restart-service`.quiet();
  const skhdRes = await $`skhd --reload`.quiet();
  const brewRes = await $`brew services restart sketchybar`.quiet();
  if (
    yabaiRes.exitCode === 0 &&
    skhdRes.exitCode === 0 &&
    brewRes.exitCode === 0
  )
    restartSpinner.succeed(
      `Restarted services in ${Date.now() - restartStart}ms`
    );
  else restartSpinner.fail("Failed to restart services");
} catch (e) {
  restartSpinner.fail("Failed to restart services");
}

console.log("");
console.log(chalk.blue(`Commit message:\n\n${commitMessage}`));
console.log("");
console.log(chalk.green(`✅ Done in ${Date.now() - start}ms`));
console.log(chalk.green("🚀 dotfiles published successfully!"));
