# action-download-artifacts

Download all artifacts from given workflow run and matching a name pattern, with an option to automatically unzip the downloaded artifacts.

## Usage

```yaml
uses: cdqag/action-download-artifacts@v1
```

### Inputs

* `github-token` _Default_: `${{ github.token }}`

    GitHub token. Required for authentication to gh cli and downloading the artifacts.

* `run-id` _Default_: `${{ github.run_id }}`

    The ID of the workflow run to download artifacts from.

* `name-pattern` _Default_: `'.*'`

    The artifact name pattern (RegExp - not glob!) to filter downloaded artifacts.

* `auto-unzip` _Default_: `'false'`

    Automatically unzip downloaded artifacts.

* `clean` _Default_: `'false'`

    Remove downloaded artifacts after use.

## About Creator

![CDQ Logo](https://www.cdq.com/themes/custom/gavias_nonid/logo.svg)

This action has been created and is maitained by [CDQ - Data Quality Solutions &amp; Services for Master Data](https://www.cdq.com/).

## License

This project is licensed under the Apache-2.0 License. See the [LICENSE](LICENSE) file for details.
