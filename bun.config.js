import { build } from "bun";

await build({
  entrypoints: ["./app/javascript/application.js"],
  outdir: "./app/assets/builds",
  target: "browser",
  format: "esm",
  minify: true,
  sourcemap: "external"
});

console.log("Build complete!");
