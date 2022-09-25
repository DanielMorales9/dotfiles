#!/bin/bash

# activate direnv
eval "$(direnv hook bash)"

# activate jump
eval "$(jump shell bash)"

# activate brew
eval "$(brew shellenv)"
