#!/bin/bash
lts=`ndenv install -ls | grep v8. | tail -n 1`
ndenv install ${lts}
ndenv global ${lts}
