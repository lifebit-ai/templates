# onboarding

A library for generating template files for making the onboarding more focused and fun, without finding for template files.

## Installation

```R
if (!require(remotes)) { install.packages("remotes") }
  remotes::install_github("lifebit-ai/onboarding")
```

## Usage

Load library

```R
library(onboarding)
```

### Create a Dockefile template

```R
create_dockerfile()
```

### Create a paramterised R-scritp template

```R
create_R_script()
```

### Create a paramterised Python-scritp template

```R
create_python_script()
```

## License

MIT © [Lifebit](https://lifebit.ai/)