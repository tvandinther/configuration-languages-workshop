package main

_alertRules: [Name=string]: #AlertGroup & {name: Name}

#AlertGroup: {
	name: string
	rules: [Name=string]: #Rule & {name: Name}
}

#Rule: {
	disabled:    bool | *false
	name:        string
	expr:        string
	for:         string | *""
	title:       string
	summary:     string
	description: string
}

_alertRules: node: rules: {
	"Unresponsive Node": {
		expr:        "k8s_node_condition_ready == 0"
		for:         "5m"
		title:       "Node not ready"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has not been ready for at least 5 minutes."
		description: "Check the status and events on the node to diagnose the issue."
	}
	"Node MemoryPressure": {
		expr:        "k8s_node_condition_memory_pressure == 1"
		for:         "5m"
		title:       "Node Memory Pressure"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has been experiencing Memory Pressure for at least 5 minutes."
		description: "There may be one or several pods using more than their requests at once without limits or limits set much higher than the request."
	}
	"Node DiskPressure": {
		expr:        "k8s_node_condition_disk_pressure == 1"
		for:         "5m"
		title:       "Node Disk Pressure"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has been experiencing Disk Pressure for at least 5 minutes."
		description: "There may be one or several pods using high amount of ephemeral local storage without appropriate requests or limits set."
	}
	"Node Expired": {
		expr:        "k8s_node_uptime_seconds_total / 86400 > 3.0"
		for:         "30m"
		title:       "Node expired"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has been running for more than 3 days."
		description: "The current value is *{{ $value }}* days. There may be several causes. One or several pods might be blocking node disruption."
	}
	"High Node Memory Usage Node": {
		expr:        "sum by(k8s_node_name,cluster) (k8s_node_memory_usage_bytes/(k8s_node_memory_available_bytes + k8s_node_memory_usage_bytes)) > 0.8"
		for:         "5m"
		title:       "High node memory usage"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has been using over 80% of its available memory for at least 5 minutes."
		description: "The current value is *{{ $value }}*. There may be one or several pods using more than their requests at once without limits or limits set much higher than the request."
	}
	"Node Low Disk Space": {
		expr:        "sum by(cluster,k8s_node_name) (k8s_node_filesystem_usage_bytes / k8s_node_filesystem_capacity_bytes) > 0.95"
		for:         "5m"
		title:       "Low disk space on node"
		summary:     "The node *{{ $labels.k8s_node_name }}* on *{{ $labels.cluster }}* has been using over 95% of its available disk space for at least 5 minutes."
		description: "The current value is *{{ $value }}*. There may be one or several pods using high amount of ephemeral local storage without appropriate requests or limits set."
	}
}

