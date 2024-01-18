#!/bin/bash

if [ ! -f "$(dirname "$(dirname "$(dirname "$( cd "$( dirname "scripts/start_qp.sh" )" >/dev/null 2>&1 && pwd )" )" )" 
)/static/.env.production" ]; then
    echo "Missing updated .env.production file in the static directory. The server may not function properly"
else
    cp "$(dirname "$(dirname "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )" )" )/static/.env.production" 
"$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"
fi

export RAILS_RELATIVE_URL_ROOT=/staff-directory
export RAILS_ENV=production

# Check if puma is started
if ! ( [ -f /opt/webapps/staff-directory/current/tmp/puma/pid ] && pgrep -F /opt/webapps/aaec/current/tmp/puma/pid > /dev/null )
then
    sudo systemctl start puma-aaec.service
else
    sudo systemctl restart puma-aaec.service
fi
