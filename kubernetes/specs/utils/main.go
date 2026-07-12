package main

import (
	"fmt"
	"log"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"

	"github.com/cli/go-gh/v2/pkg/api"
)

var repos = map[string]string{
	"kahnwong/aqi-notify":         "../jobs/jobs/aqi-notify.yaml",
	"kahnwong/cpubench":           "../deployments/services/cpubench.yaml",
	"kahnwong/dashboard":          "../deployments/services/dashboard.yaml",
	"kahnwong/docker-fava":        "../deployments/services/fava.yaml",
	"kahnwong/docker-mlflow":      "../deployments/infrastructure/mlflow.yaml",
	"kahnwong/ical-to-rss":        "../deployments/news/thai-tech-cal.yaml",
	"kahnwong/line-notify":        "../jobs/jobs/food-01-1-lunch-ask.yaml",
	"kahnwong/livegrep-utils":     "../jobs/services/livegrep-clone.yaml",
	"kahnwong/llm-honeypot":       "../deployments/infrastructure/llm-honeypot.yaml",
	"kahnwong/qrcode-api":         "../deployments/services/qrcode-api.yaml",
	"kahnwong/retrooo":            "../deployments/services/retrooo.yaml",
	"kahnwong/rustpad":            "../deployments/services/rustpad.yaml",
	"kahnwong/sshx":               "../deployments/services/sshx.yaml",
	"kahnwong/subsonic-widgets":   "../deployments/services/subsonic-widgets.yaml",
	"kahnwong/sup3rs3cretmes5age": "../deployments/services/supersecretmessage.yaml",
	"kahnwong/todotxt":            "../deployments/services/todotxt.yaml",
	"kahnwong/wabbajack":          "../deployments/services/wabbajack.yaml",
	"kahnwong/water-cut-notify":   "../jobs/jobs/water-cut-notify.yaml",
	"kahnwong/weather-api":        "../deployments/services/weather-api.yaml",
}

func main() {
	for repo, path := range repos {
		sha, err := latestDefaultBranchSHA(repo)
		if err != nil {
			log.Fatal(err)
		}

		shortSHA := sha
		if len(shortSHA) > 7 {
			shortSHA = shortSHA[:7]
		}

		path = filepath.Clean(path)
		if err := updateImageTag(path, "ghcr.io/"+repo, shortSHA); err != nil {
			log.Fatal(err)
		}

		fmt.Printf("updated %s to %s in %s\n", repo, shortSHA, path)
	}
}

func latestDefaultBranchSHA(repo string) (string, error) {
	client, err := api.DefaultRESTClient()
	if err != nil {
		return "", err
	}

	var repository struct {
		DefaultBranch string `json:"default_branch"`
	}
	if err := client.Get("repos/"+repo, &repository); err != nil {
		return "", err
	}
	if repository.DefaultBranch == "" {
		return "", fmt.Errorf("repo %s has no default branch", repo)
	}

	var branch struct {
		Commit struct {
			SHA string `json:"sha"`
		} `json:"commit"`
	}
	path := fmt.Sprintf("repos/%s/branches/%s", repo, url.PathEscape(repository.DefaultBranch))
	if err := client.Do(http.MethodGet, path, nil, &branch); err != nil {
		return "", err
	}
	if branch.Commit.SHA == "" {
		return "", fmt.Errorf("default branch %q for repo %s has no commit sha", repository.DefaultBranch, repo)
	}

	return branch.Commit.SHA, nil
}

func updateImageTag(path, repository, tag string) error {
	b, err := os.ReadFile(path)
	if err != nil {
		return err
	}

	lines := strings.SplitAfter(string(b), "\n")
	containerStart := -1
	containerIndent := ""
	for i, line := range lines {
		trimmed := strings.TrimSpace(line)
		if strings.HasPrefix(trimmed, "- name:") {
			containerStart = i
			containerIndent = line[:len(line)-len(strings.TrimLeft(line, " \t"))]
			continue
		}

		if containerStart == -1 || trimmed != "repository: "+repository {
			continue
		}

		for j := i + 1; j < len(lines); j++ {
			current := lines[j]
			currentTrimmed := strings.TrimSpace(current)
			currentIndent := current[:len(current)-len(strings.TrimLeft(current, " \t"))]

			if strings.HasPrefix(currentTrimmed, "- name:") && currentIndent == containerIndent {
				break
			}
			if strings.HasPrefix(currentTrimmed, "tag:") {
				newline := ""
				if strings.HasSuffix(current, "\n") {
					newline = "\n"
				}
				lines[j] = currentIndent + "tag: " + tag + newline
				return os.WriteFile(path, []byte(strings.Join(lines, "")), 0644)
			}
		}

		return fmt.Errorf("repository %s in %s has no tag field", repository, path)
	}

	return fmt.Errorf("repository %s not found in %s", repository, path)
}
