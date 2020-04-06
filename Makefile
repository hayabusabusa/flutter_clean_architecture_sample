.PHONY: inject-access-token

inject-access-token:
		echo "const String qiitaAccessToken = '${TOKEN}';" > ./lib/secret.dart