package main

import gh "github.example@v0:actions"

gh.#Workflow & {
    name: "GitHub Actions Demo"
    on: ["push"]
    jobs: {
        "Explore-GitHub-Actions": gh.#Workflow.#normalJob & {
            "runs-on": "ubuntu-latest" // Try change this to "macos-latest" and run `cue vet`
            steps: [
                {
                    name: "Check out repository code"
                    uses: "actions/checkout@v4"
                },
                {
                run: """
                echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
                """  
                }
            ]
        }
    }
}
