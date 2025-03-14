package main

import (
	"cue.example/prometheus"
	kcore "github.com/cue-tmp/jsonschema-pub/exp3/k8s.io/api/core/v1"
	"encoding/yaml"
)

_config: prometheus
_config: groups: [for alertGroup in _alertRules {
	name: alertGroup.name
	rules: [for alertRule in alertGroup.rules {
		alert: alertRule.name
		expr:  alertRule.expr
		for:   alertRule.for
		annotations: {
			title:       alertRule.title
			summary:     alertRule.summary
			description: alertRule.description
		}
	}]
}]

kcore.#ConfigMap & {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name:         "prometheus-config"
	data: "prometheus.yml": yaml.Marshal(_config)
}