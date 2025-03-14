# Configuration Languages Workshop

In this workshop you will familiarise yourself with configuration languages and get hands-on with both CUE and KCL.

> [Unlock your Infrastructure-as-Code with the power of Configuration Languages (devoteam.com)](https://www.devoteam.com/expert-view/infrastructure-as-code-with-configuration-languages/)

## Setup

To access the required tools in this workshop you will be using [Devbox](https://www.jetify.com/devbox) to create ephemeral shells.

> Before we get started and install Devbox, please note the following:
> 
> - Devbox can only be used on Windows within WSL2
> - Devbox is based on the Nix Package Manager. Installing Devbox will also install the Nix Package Manager if not already installed.
> 
> If either of these points are a problem, you may install the CUE and KCL binaries directly.
> - https://cuelang.org/docs/introduction/installation/
> - https://www.kcl-lang.io/docs/user_docs/getting-started/install

### Steps
1. Install Devbox: https://www.jetify.com/docs/devbox/installing_devbox/
1. Clone this repository to your local machine.
1. Run `devbox shell` to open a new shell with the required binaries available.
1. If using VS Code: install the recommended extensions.

## Task

We have some prometheus alert rules defined and we want to get these embedded into a Kubernetes ConfigMap ensuring that the correct schema is followed to avoid any issues when it comes time to apply the ConfigMap to the Kubernetes API Server, and to ensure that the Prometheus server will not reject the configuration.

Your task is to pick either [CUE](https://cuelang.org/docs/) or [KCL](https://www.kcl-lang.io/docs/reference/lang/tour) and to write the code which takes the alert rules already defined in code, and generates a YAML output for a valid Prometheus configuration embedded in a valid Kubernetes ConfigMap.

Below is an abridged example of the expected output:
```yaml
apiVersion: v1
data:
  prometheus.yml: |
    groups:
      - name: node
        rules:
          - alert: Unresponsive node
            expr: k8s_node_condition_ready == 0
            for: 5m
            annotations:
              title: Node not ready
              summary: The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has not been ready for at least 5 minutes.
              description: Check the status and events on the node to diagnose the issue.
kind: ConfigMap
metadata:
  name: prometheus-config
```

You will find everything you need in the [cue](./cue/) and [kcl](./kcl/) directories. There will be instructions, as well as a handy syntax cheatsheet to give you the information you need to complete the task.

Once you complete the task, try it again with the other langauge. See which one you prefer!
