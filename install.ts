import { $ } from "bun"

const brewFile = Bun.file("brew_packages.txt")
const packages = (await brewFile.text()).split("\n")

const total = packages.length
let count: number = 0;
for (const pack of packages) {
    console.log(`Installing ${pack}...`)
    const startTime = Date.now()
try {
    const result = await $`brew install ${pack}`.quiet();
    if (result.exitCode === 0) {
        console.log(`Successfully installed ${pack} in ${(Date.now() - startTime) / 1000} seconds ${count}/${total}`)
}
} catch {
console.log(`failed to install ${pack}`)
}
   }

await $`brew cleanup`

await $`brew doctor`