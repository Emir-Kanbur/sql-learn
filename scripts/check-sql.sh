#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
password="SqlLearn!$(openssl rand -hex 16)"
container=$(MSSQL_SA_PASSWORD="$password" docker run --rm --detach \
  --platform linux/amd64 --env ACCEPT_EULA=Y --env MSSQL_SA_PASSWORD \
  mcr.microsoft.com/mssql/server:2022-latest)
trap 'docker rm -f "$container" >/dev/null || true' EXIT

sqlcmd() {
  docker exec -i "$container" sh -c '
    export SQLCMDPASSWORD="$MSSQL_SA_PASSWORD"
    exec /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -b -l 3 "$@"
  ' sqlcmd "$@"
}

for ((attempt = 1; attempt <= 60; attempt++)); do
  if sqlcmd -d master -Q 'SELECT 1;' >/dev/null 2>&1; then
    break
  fi
  if (( attempt == 60 )); then
    docker logs "$container" >&2
    echo 'SQL Server bağlantı kabul etmedi.' >&2
    exit 1
  fi
  sleep 2
done

sqlcmd -d master -Q 'CREATE DATABASE SqlLearnCheck;'
sqlcmd -d SqlLearnCheck -i /dev/stdin < setup.sql
sqlcmd -d SqlLearnCheck -i /dev/stdin < setup.sql
sqlcmd -d SqlLearnCheck -i /dev/stdin < tests/verify-setup.sql
sqlcmd -d SqlLearnCheck -i /dev/stdin < YOBU/bmh236/setup.sql
sqlcmd -d SqlLearnCheck -i /dev/stdin < YOBU/bmh236/setup.sql
sqlcmd -d SqlLearnCheck -i /dev/stdin < tests/verify-bmh236.sql
for file in lessons/*/{lesson,solutions}.sql YOBU/bmh236/*/{lesson,solutions}.sql; do
  printf 'Sorgular doğrulanıyor: %s\n' "$file"
  sqlcmd -d SqlLearnCheck -i /dev/stdin < "$file" >/dev/null
done

echo 'Kurulum ve ders sorguları doğrulandı.'
