# Prometheus Alerts

This sandbox shows how KCL can help to define Prometheus alerts.

## Steps
1. Run `kcl mod init`.
1. Download the JSON Schema from [GitHub](https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/prometheus.rules.json).
1. Move the JSON Schema into a new directory named `prometheus`.
1. In the new `prometheus` directory run `kcl import -m jsonschema prometheus.rules.json`
1. In `main.k` `import prometheus` and define your rules by starting with the `prometheus.PrometheusRules{}` schema.
1. Get the k8s module with `kcl mod add k8s`.
1. `import k8s.api.core.v1 as kcore` and create a ConfigMap using the `kcore.ConfigMap{}` schema.
1. `import yaml` and place your rules as a YAML string into the config map's `data` field using `yaml.encode()`.
1. Run `kcl run` to generate YAML output of `main.k`.
1. Run `kcl fmt` to format your code.