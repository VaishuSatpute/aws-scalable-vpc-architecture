#!/bin/bash
set -euo pipefail

# Bootstrap script for an EC2 application server.
# Supply S3_BUCKET_NAME through the environment or instance user data.

if [ -z "${S3_BUCKET_NAME:-}" ]; then
  echo "S3_BUCKET_NAME is not set"
  exit 1
fi

if [ -f /etc/os-release ]; then
  . /etc/os-release
else
  echo "Cannot detect operating system"
  exit 1
fi

if [ "$ID" = "amzn" ]; then
  yum update -y
  yum install -y awscli httpd amazon-cloudwatch-agent
  systemctl enable --now httpd
  WEB_ROOT=/var/www/html
elif [ "$ID" = "ubuntu" ]; then
  apt-get update -y
  apt-get install -y unzip curl apache2
  systemctl enable --now apache2
  WEB_ROOT=/var/www/html
else
  echo "Unsupported OS: $ID"
  exit 1
fi

aws s3 cp "s3://${S3_BUCKET_NAME}/index.html" "${WEB_ROOT}/index.html"

cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'EOF'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "system-logs",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOF

echo "EC2 bootstrap completed."
