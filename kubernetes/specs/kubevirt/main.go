package main

import (
	"bufio"
	"bytes"
	_ "embed"
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"text/template"
)

//go:embed templates/vm.yaml
var manifestTemplate string

//go:embed templates/cloudinit.yaml
var cloudInitTemplate string

var osImages = struct {
	debian string
	ubuntu string
}{
	debian: "docker://quay.io/containerdisks/debian:latest",
	ubuntu: "docker://quay.io/containerdisks/ubuntu:26.04",
}

// Use distinct names and NodePorts for VMs that will coexist.
var configs = []Config{
	{
		Name:     "debian",
		NodePort: 30200,
		Memory:   "512Mi",
		CPU:      "1",
		//Username: "debian",
		//Password: "debian", // change on first boot via `passwd`
		Image: osImages.debian,
	},
	{
		Name:     "ubuntu",
		NodePort: 30201,
		Memory:   "512Mi",
		CPU:      "1",
		Image:    osImages.ubuntu,
	},
	{
		Name:     "apps",
		NodePort: 30202,
		Memory:   "512Mi",
		CPU:      "1",
		Image:    osImages.debian,
	},
}

type Config struct {
	Name     string
	NodePort int
	Memory   string
	CPU      string
	Username string
	Password string
	Image    string
}

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
}

func run() error {
	action := "apply"
	if len(os.Args) > 2 {
		return fmt.Errorf("usage: go run main.go [apply|delete]")
	}
	if len(os.Args) == 2 {
		switch os.Args[1] {
		case "apply", "delete":
			action = os.Args[1]
		case "-h", "--help":
			fmt.Println("Usage: go run main.go [apply|delete]")
			fmt.Println("Select a VM configuration interactively. Defaults to apply.")
			return nil
		default:
			return fmt.Errorf("unknown subcommand %q; usage: go run main.go [apply|delete]", os.Args[1])
		}
	}

	if len(configs) == 0 {
		return fmt.Errorf("no configurations defined in main.go")
	}

	fmt.Printf("Select a configuration to %s using the current kubectl context:\n", action)
	if action == "delete" {
		fmt.Println("Warning: deleting a VM may also delete its associated storage and data.")
	}
	for i, config := range configs {
		fmt.Printf("  %d) %s (CPU: %s, memory: %s, SSH NodePort: %d)\n",
			i+1, config.Name, config.CPU, config.Memory, config.NodePort)
	}
	fmt.Println("  q) Cancel")

	scanner := bufio.NewScanner(os.Stdin)
	var selected Config
	for {
		fmt.Print("Configuration number: ")
		if !scanner.Scan() {
			if err := scanner.Err(); err != nil {
				return fmt.Errorf("read selection: %w", err)
			}
			fmt.Println("\nCancelled.")
			return nil
		}
		input := strings.TrimSpace(scanner.Text())
		if strings.EqualFold(input, "q") {
			fmt.Println("Cancelled.")
			return nil
		}
		index, err := strconv.Atoi(input)
		if err != nil || index < 1 || index > len(configs) {
			fmt.Printf("Enter a number from 1 to %d, or q to cancel.\n", len(configs))
			continue
		}
		selected = configs[index-1]
		break
	}

	cloudInit, err := renderTemplate("cloud-init", cloudInitTemplate, selected)
	if err != nil {
		return err
	}
	data := struct {
		Config
		CloudInit string
	}{
		Config:    selected,
		CloudInit: cloudInit,
	}
	manifest, err := renderTemplate("vm", manifestTemplate, data)
	if err != nil {
		return err
	}

	fmt.Printf("Running kubectl %s for %s using the current context (namespace vms)...\n", action, selected.Name)
	args := []string{action, "-f", "-"}
	if action == "delete" {
		args = append(args, "--ignore-not-found=true")
	}
	cmd := exec.Command("kubectl", args...)
	cmd.Stdin = strings.NewReader(manifest)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		return fmt.Errorf("kubectl %s: %w", action, err)
	}
	return nil
}

func renderTemplate(name, source string, data any) (string, error) {
	tmpl, err := template.New(name).Option("missingkey=error").Funcs(template.FuncMap{
		// JSON string quoting is also valid YAML quoting.
		"quote": func(value string) (string, error) {
			encoded, err := json.Marshal(value)
			return string(encoded), err
		},
		"indent": func(spaces int, value string) string {
			prefix := strings.Repeat(" ", spaces)
			return prefix + strings.ReplaceAll(strings.TrimRight(value, "\n"), "\n", "\n"+prefix)
		},
	}).Parse(source)
	if err != nil {
		return "", fmt.Errorf("parse %s template: %w", name, err)
	}
	var output bytes.Buffer
	if err := tmpl.Execute(&output, data); err != nil {
		return "", fmt.Errorf("render %s template: %w", name, err)
	}
	return output.String(), nil
}
