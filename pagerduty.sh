#!/usr/bin/env sh

PD_API_KEY="API_KEY"
SERVICE_KEY="SERVICE_KEY"
PD_EMAIL="VALID_PD_EMAIL"
DRY_RUN=""

# ========== Pagerduty Setup

# 1. You must first create an API key - stick with v2 since v1 is going away

# 2. Then create a service - in the URL of the service will be the service key
#  Example: https://XcompanyX.pagerduty.com/services/SERVICE_KEY

# 3. The API key gets filled into the PD_API_KEY variable

# 4. The service key gets filled into the SERVICE_KEY variable

# 5. A valie PagerDuty email address must be filled into the PD_EMAIL variable

# ========== Usage and Arguments

usage() {
    cat <<-EOF

  Usage: $0 -t <title> -d <detail> [-n]

  This script will create a PagerDuty alert

  Required arguments:
    -t  Title for the alert
    -d  Incident detail

  Optional arguments:
    -h  This help
    -n  Dry run

EOF
    exit 255
}

while getopts "t:d:hn" OPT; do
    case "${OPT}" in
        t) title=${OPTARG};;
        d) detail=${OPTARG};;
        h) usage;;
        n) DRY_RUN="echo";;
        ?)
          echo "Invalid option: -$OPTARG" >&2
          usage
          ;;
        *) usage;;
    esac
done

if [[ -z "${title}" ]] || [[ -z "${detail}" ]]; then
    echo
    [[ -z "${title}" ]]  && echo "You did not provide an incident title."
    [[ -z "${detail}" ]] && echo "You did not provide incident detail."
    echo "==================================================================="
    usage
fi

# ========== Send The Alert

${DRY_RUN} curl -X POST \
--header 'Content-Type: application/json' \
--header 'Accept: application/vnd.pagerduty+json;version=2' \
--header "From: ${PD_EMAIL}" \
--header "Authorization: Token token=${PD_API_KEY}" \
-d "{
  'incident': {
    'type':'incident',
    'title': '${title}',
    'service': {
      'id': '${SERVICE_KEY}',
      'type': 'service_reference'
    },
    'body': {
      'type': 'incident_body',
      'details': '${detail}'
    }
  }
}" 'https://api.pagerduty.com/incidents'
