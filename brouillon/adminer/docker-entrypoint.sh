#! /bin/bash
set -e

main() {
  echo "Starting php-fpm on port :9000"
  exec "$@"
}

main "$@"
