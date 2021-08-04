docker run -it --env-file=.env -e "CONFIG=$(cat algolia-config.json | jq -r tostring)" algolia/docsearch-scraper
