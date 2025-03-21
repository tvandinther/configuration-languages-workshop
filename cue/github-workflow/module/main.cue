package main

import (
    "github-workflow.example/github@v0"
    "strings"
)

#Workflow: github.#Workflow

#Workflow: {
    #normalJob: "runs-on": strings.HasPrefix("ubuntu-")
}

workflow: #Workflow & {
    jobs: foo: workflow.#normalJob & {
        "runs-on": "ubuntu-latest" // Try change this to "macos-latest" and run `cue vet`
    }
}