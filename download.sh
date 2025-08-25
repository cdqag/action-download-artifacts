#!/usr/bin/env bash

# Created by CDQ AG, 2025
# Apache-2.0 License

set -e

if [[ -z "$GH_TOKEN" ]]; then
	echo "GH_TOKEN cannot be an empty string"
	exit 10
fi

if [[ -z "$RUN_ID" ]]; then
	echo "RUN_ID cannot be an empty string"
	exit 11
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
	echo "GITHUB_REPOSITORY cannot be an empty string"
	exit 12
fi

if [[ -z "$NAME_PATTERN" ]]; then
	echo "NAME_PATTERN cannot be an empty string"
	exit 13
fi


echo "Fetching list of artifacts..."
artifacts=$(gh api --paginate "/repos/$GITHUB_REPOSITORY/actions/runs/$RUN_ID/artifacts")
artifacts=$(echo "$artifacts" | jq -rc '.artifacts[]')

if [[ -z "$artifacts" ]]; then
	echo "No artifacts found for run ID $RUN_ID"
	exit 20
fi


# Iterate over found artifacts
while IFS= read -r artifact; do
	artifact_name=$(echo "$artifact" | jq -r '.name')
	if ! [[ "$artifact_name" =~ $NAME_PATTERN ]]; then
		echo "Skipping artifact '$artifact_name' as it does not match pattern '$NAME_PATTERN'"
		continue
	fi

	artifact_url=$(echo "$artifact" | jq -r '.archive_download_url')
	echo "Found artifact: $artifact_name (URL: $artifact_url)"

	artifact_zip_name="${artifact_name}.zip"

	echo "Downloading..."
	curl -L -s -H "Authorization: token $GH_TOKEN" -o "$artifact_zip_name" "$artifact_url"
	echo "Done"

	if [[ "$AUTO_UNZIP" == "true" ]]; then
		echo "Unzipping..."
		unzip -o "$artifact_zip_name"
		echo "Done"
	fi

done <<< "$artifacts"
