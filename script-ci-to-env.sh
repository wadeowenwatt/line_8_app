
#!/usr/bin/env bash
bash << EOF
echo "$FIREBASE_APP_ID"
echo "$CI_ENVIRONMENT_NAME"
echo "$FIREBASE_APP_ID" >> ".env.$CI_ENVIRONMENT_NAME"
EOF

