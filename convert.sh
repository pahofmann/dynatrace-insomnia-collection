#!/bin/bash
for file in ./Insomnia*.json
do
	echo Processing $file
	echo "  Replacing base_bath..."
	sed -e 's/"base_path": ".*"/"base_path": ""/g' -i $file

	echo "  Replacing host..."
	sed -e 's/"host": ".*"/"host": "*.live.dynatrace.com OR your-dtmanaged.com\/e\/ENVID"/g' -i $file

	echo "  Renaming Environment..."
	sed 's/"OpenAPI env"/"Dynatrace Example Env"/g' -i $file

	echo "  Replacing auth header..."
	sed 's/: "authorization"/: "Api-Token REPLACE_ME_WITH_TOKEN"/g' -i $file

	echo "  Removing base_bath from enivronment..."
	sed 's/{{ base_path }}//g' -i $file
	
	echo "  Cleaning url..."
	sed -e 's/\\"url\\" : \\".*\\",\\n/\\"url\\" : \\"\\",\\n/g' -i $file

	echo "  Setting api context root..."
	if [[ "$file" == *"Environment-v1"* ]];then
		sed 's/{{ base_url }}/{{ base_url }}\/api\/v1/g' -i $file
	fi
	if [[ "$file" == *"Environment-v2"* ]];then
		sed 's/{{ base_url }}/{{ base_url }}\/api\/v2/g' -i $file
	fi
	if [[ "$file" == *"Configuration-v1"* ]];then
		sed 's/{{ base_url }}/{{ base_url }}\/api\/config\/v1/g' -i $file
	fi
	if [[ "$file" == *"Cluster-v1"* ]];then
		sed 's/{{ base_url }}/{{ base_url }}\/api\/v1.0\/onpremise/g' -i $file
	fi
	if [[ "$file" == *"Cluster-v2"* ]];then
		sed 's/{{ base_url }}/{{ base_url }}\/api\/cluster\/v2/g' -i $file
	fi
done
