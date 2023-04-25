
#!/usr/bin/env bash
bash << EOF
echo "$FIREBASE_APP_ID"
echo "${FIREBASE_APP_ID}"
echo "$CI_ENVIRONMENT_NAME"
if [ -z "${FIREBASE_APP_ID}" ]; then echo "FIREBASE_APP_ID=$FIREBASE_APP_ID" >> ".env.$CI_ENVIRONMENT_NAME"; fi
EOF

