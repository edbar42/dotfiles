#!/bin/bash

set -e

echo "Generating pt_BR.UTF-8..."

sudo sed -i 's/^#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen

sudo locale-gen

echo "Locale generated. Restart services that might need it for proper use."
