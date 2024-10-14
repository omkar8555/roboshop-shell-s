source common.sh
app_name=dispatch


if [ -z "$1" ]; then
  echo INput RABBITMQ_PASSWORD is missing
  exit 1
fi

RABBITMQ_PASSWORD=$1

golang_setup










