#!/bin/bash -eu
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
OUTPUT_FILE="encrypted-output.gpg"

docker build -t apticron-test .
docker run --rm --name apticron-test -t apticron-test:latest bash -c "apticron && sleep 7 && sed -n '/.*BEGIN PGP MESSAGE.*/,/.*END PGP MESSAGE.*/p' /var/mail/mail" > $OUTPUT_FILE
gpg -d $OUTPUT_FILE
