First we will define a module which contains the GitHub Workflow schema as well as any policy which we want to enforce.
1. Create a new directory called `schema-module`.
1. Download the GitHub Workflow JSON Schema from [GitHub](https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json) into the newly created directory.
1. Run `cue mod init github.example@v0 --source=git` to initialise the CUE module.
1. Run `cue import github-workflow.json -p actions -l '#Workflow:'` to generate CUE code based on the JSON Schema.
1. Create a file `policy.cue` for the `actions` package, and define a constraint for the `job.runs-on` field to only allow values starting with `"ubuntu-"`.
1. Add any other constraints for policy you want to enforce.
1. Create a local container registry by running `cue mod registry localhost:5001` in another terminal window or in the background.
1. Publish your module to the registry with `cue mod publish v0.0.1`.

Now we will use the published module to author a GitHub Workflow file. In the `workflow` directory:
1. Get the module from the registry using `cue mod get github.example@v0`.
1. In `main.cue`, `import gh "github.example@v0:actions"` and begin defining your workflow. Use the `#Workflow` definition from the imported package as your starting point, i.e. `gh.#Workflow & {}`.
1. Try set the `runs-on` field in one of your jobs to `"macos-latest"` and run `cue vet` to see the output fail. Change this back to a string prefixed with `"ubuntu-"` to remove this error.
1. Finally, run `cue export --out yaml` to view the generated GitHub Workflow markup.

Example GitHub Workflow output:
```yaml
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository code
        uses: actions/checkout@v4
      - run: "echo \"🎉 The job was automatically triggered by a ${{ github.event_name }} event.\""
name: GitHub Actions Demo
"on":
  - push
```

## Troubleshooting

```
cannot put module: cannot make scratch config: 404 Not Found: name unknown: module "demo.example/config" is not supported (only github.com/owner/repo/... is currently allowed)
```
Ensure that the environment variable `CUE_REGISTRY` is set to `localhost:5001`.

## Useful Resources

- [CUE Standard Package - strings](https://pkg.go.dev/cuelang.org/go/pkg/strings)
