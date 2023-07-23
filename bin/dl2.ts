#!/usr/bin/env -S deno run -A

import $ from "https://deno.land/x/dax/mod.ts";
import { parse } from "https://deno.land/std@0.182.0/path/mod.ts";

let files = []

/*
  Some magic to allow extremely simple input/renaming functinality like
   dl https://speedtest.tele2.net/100Mb.zip http://speedtest.tele2.net/10Mb.zip foobar.zip
   { url: "https://speedtest.tele2.net/100Mb.zip", output: "100Mb.zip" },
   { url: "http://speedtest.tele2.net/10Mb.zip", output: "foobar.zip" }
*/

for (let i = 0; i < Deno.args.length; i++) {
  const arg = Deno.args[i]
  const dl = { url: '', output: '' }

  if (/http(s?):/.test(arg)) {
    dl.url = arg
    dl.output = parse(dl.url).base
  } else {
    (files[i -1]).output = arg
  }
  files.push(dl)
}
files = files.filter(dl => dl.url)



const pb = $.progress('Downloading files ...')
const cmds = files.map(dl => {

  return $`bash -c "
    curl \
    --silent \
    --location \
    --keepalive \
    --connect-timeout 5 \
    --retry 0 \
    --fail \
    --compressed \
    --progress-bar \
    -o ${dl.output} \
    ${dl.url}
  "
  `.then(val => console.log(dl.url))
})

await Promise.all(cmds)
pb.finish()
