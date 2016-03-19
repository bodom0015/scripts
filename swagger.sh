#!/bin/bash

# Delete old spec
sudo rm -f swagger/swagger-spec.json

# Grab the newest swagger spec
sudo curl -L https://raw.githubusercontent.com/nds-org/nds-labs/NDS-108/apis/swagger-spec/ndslabs.json > swagger/swagger-spec.json

# Generate our REST API from this spec using swagger-js-codegen
docker run --rm -it -v /home/core/workspace/containers/nds-labs/experiments/prototype-gui/src:/data digitallyseamless/nodejs-bower-grunt node swagger/generate-angular.js > app/shared/NdsLabsRestApi.js
