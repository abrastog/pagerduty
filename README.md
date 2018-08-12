# PagerDuty

The pagerduty.sh script is used as a simple way to create an incident.  I did not need a full blown client.

## Setup

1. You must first create an API key - stick with v2 since v1 is going away

2. Then create a service - in the URL of the service will be the service key
   - Example: https://XcompanyX.pagerduty.com/services/SERVICE_KEY

3. The API key gets filled into the PD_API_KEY variable

4. The service key gets filled into the SERVICE_KEY variable

5. A valid PagerDuty email address must be filled into the PD_EMAIL variable

## Usage

```shell
$ ./pagerduty.sh -h     

  Usage: ./pagerduty.sh -t <title> -d <detail> [-n]

  This script will create a PagerDuty alert

  Required arguments:
    -t  Title for the alert
    -d  Incident detail

  Optional arguments:
    -h  This help
    -n  Dry run
```
