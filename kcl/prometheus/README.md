# Prometheus Alerts

This sandbox shows how KCL can help to define Prometheus alerts.

## Steps
1. Download the JSON Schema from [GitHub](https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/prometheus.rules.json).
1. Move the JSON Schema into a new directory named `prometheus`.
1. In the new `prometheus` directory run `kcl import -m jsonschema prometheus.rules.json`
1. In `main.k` `import prometheus` and define your rules by starting with the `prometheus.PrometheusRules{}` schema.
1. Get the k8s module with `kcl mod add k8s`.
1. `import k8s.api.core.v1 as kcore` and create a ConfigMap using the `kcore.ConfigMap{}` schema.
1. `import yaml` and place your rules as a YAML string into the config map's `data` field using `yaml.encode()`.
1. Run `kcl run` to generate YAML output of `main.k`.
1. Run `kcl fmt` to format your code.

## Syntax Cheatsheet

### Packages

In KCL, all files in the same **directory** share a namespace. A package is defined by the name of its containing directory.

Importing a package is done by using an import statement along with the name of the directory. E.g.
```python
import .directory # Using the period indicates that KCL should look for a directory first. You may omit the period in which case KCL will first look for other named packages before searching for a directory.
```

### Fields

Fields come in two flavours, identifiers and dict or schema fields. Identifiers are variable names and typically exist in the top scope, or in assignments outside of dicts and schemas.

In both cases fields are immutable unless they are prefixed with an underscore (`_`) in which case they are also not exported.
```python
exported = "Hello"
_notExported = "World!"
_notExported = "mutable"
```

### Comprehensions

Lists and structs can be constructed using comprehensions over other collection types (lists and structs). This syntax allows you to dynamically generate your data structures from another data structure.

```python
environmentVariables = {
    FOO: "BAR"
    BAZ: "QUX"
}

envList = [{
    name: key
    value: val
} for key, val in environmentVariables]

valuesAsKeys = {val: key for key, val in environmentVariables}

lotteryNumbers = [5, 23, 11, 8, 2, 27, 12]

winningLotteryNumbers = [{
    order: i + 1
    number: num
} for i, num in lotteryNumbers]

# This example also shows string interpolation
winningLotteryNumbersStruct = {"${i + 1}" = num for i, num in lotteryNumbers}
```

### Schemas

KCL defines schemas using the `schema` keyword. E.g.
```python
schema Person:
    name: str
    age: int
    retired: bool
```

You can then create an instance of a schema which means that the provided values will be checked against the schema. E.g.
```python
person = Person {
    name = "John"
    age = 40
    retired = False
}
```

### Defaults

In KCL you can define a default value for a schema using the assignment operator (`=`). E.g.
```python
schema Example:
    stringWithDefault: str = "default"
```
