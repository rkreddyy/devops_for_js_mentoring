#!/bin/bash

# Move to project folder.
cd ../../shop-angular-cloudfront && npm run lint && npm run test && npm audit

if [ $? -eq 0 ]; then
    echo "SUCCESS"
else
    echo "FAIL"
fi