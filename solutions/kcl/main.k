import prometheus as p
import k8s.api.core.v1 as kcore
import yaml

_rules = p.PrometheusRules {
    groups = [p.PrometheusRulesGroupsItems0 {
        name = alertGroup.name
        rules = [p.AlertingRule{
            alert = alertRule.name
            expr = alertRule.expr
            $for = alertRule.for
            annotations = p.Annotations{
                title = alertRule.title
                summary = alertRule.summary
                description = alertRule.description
            }
        } for _, alertRule in alertGroup.rules]
    } for _, alertGroup in _alertRules]
}

kcore.ConfigMap {
    metadata.name = "prometheus-config"
    data = {
        "prometheus.yml" = yaml.encode(_rules)
    }
}