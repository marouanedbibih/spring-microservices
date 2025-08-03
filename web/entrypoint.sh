#!/bin/sh

echo "Generating runtime env.js..."
cat <<EOF > /usr/share/nginx/html/env.js
window._env_ = {
  REACT_APP_API_URL: "${REACT_APP_API_URL}",
};
EOF

echo "Starting Nginx..."
exec "$@"
