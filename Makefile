SHELL := /bin/bash

REGION ?= us-east-1
PHP_VERSION ?= 7.2.14
PHP_VERSION_SHORT ?= 7.2
PHP_VERSION_SHORT_UNDERSCORE = $(subst .,_,${PHP_VERSION_SHORT})

distribution: build
	rm -rf export/
	docker build --no-cache -f ${PWD}/export.Dockerfile -t sts/runtime/dist:latest .
	docker run --name sts-export-container sts/runtime/dist:latest /bin/true
	docker cp  sts-export-container:/export .
	docker cp  sts-export-container:/opt/php/etc/php/php.ini .
	docker rm  sts-export-container

build:
	docker build -f ${PWD}/php.Dockerfile  -t sts/runtime/php:latest $(shell helpers/docker_args.php php72) --build-arg installDir=/opt/php .

publish:
	$(eval LAYER_NAME = sts-php-${PHP_VERSION_SHORT_UNDERSCORE})

	# Publish the layer
	$(eval LAYER_VERSION = $(shell aws lambda publish-layer-version --region=${REGION} --layer-name ${LAYER_NAME} --description "PHP ${PHP_VERSION}" --license-info "MIT" --zip-file fileb://export/php-${PHP_VERSION}.zip --compatible-runtimes provided --output text --query Version))

	# Add layer permissions
	$(eval RESOURCE = $(shell aws lambda add-layer-version-permission \
		--region=${REGION} \
		--layer-name ${LAYER_NAME} \
		--version-number ${LAYER_VERSION} \
		--statement-id=public \
		--action lambda:GetLayerVersion \
		--principal '*' | python2 -c "import sys, json; print json.load(sys.stdin)['Statement']" | python2 -c "import sys, json; print json.load(sys.stdin)['Resource']"))

	echo "Done! Published ${RESOURCE}"