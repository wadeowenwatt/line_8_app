
#!/usr/bin/env bash
bash << EOF
if [ -z "${FIREBASE_APP_ID}" ]; then echo "FIREBASE_APP_ID=$FIREBASE_APP_ID" >> ".env.$CI_ENVIRONMENT_NAME"; fi
if [ -n "${FIREBASE_APP_ID}" ]; then echo "$FIREBASE_APP_ID"; fi
if [ -z "${FIREBASE_APP_ID}" ]; then echo "$FIREBASE_APP_ID"; fi
EOF

