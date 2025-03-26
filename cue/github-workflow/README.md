
1. In the `actions` directory:
1. Download the GitHub Workflow JSON Schema from [GitHub](https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json).
1. Move the JSON Schema into a new directory named `github`.
1. Run `cue import github/github-workflow.json -p github -l '#Workflow:'`
1. In `main.cue`, `import "github-workflow.example@v0/github"` and lets begin adding some contraints.
1. `cue mod publish v0.0.1`

1. In the `workflow` directory:
1. Get the module from the registry using `cue mod get github.example@v0`.
1. In `main.cue`, `import gh "github.example/actions@v0"` and begin defining your workflow. Use the `#Workflow` definition from the imported package as your starting point.

## Troubleshooting

```
cannot put module: cannot make scratch config: 404 Not Found: name unknown: module "demo.example/config" is not supported (only github.com/owner/repo/... is currently allowed)
```
Ensure that the environment variable `CUE_REGISTRY` is set to `localhost:5001`.