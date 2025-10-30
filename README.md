# zenv

Manual development environment creation made easy.

## Brief

Creates a development environment by installing a
list of applications configured by the user and
making them available in PATH.

## How it works

User has to create a configuration file containing
the specification for all the required
applications. The tool will then process this file
and automatically install everything locally.

### App specification file

```
[package-name]
command = ""
[package-name1]
command = ""
...
```
