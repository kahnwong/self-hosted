package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {
	services := map[string]string{
		"garage": "30070",
		"ntfy":   "30022",
		"sshx":   "30028",
	}

	// generate config
	config := generateConfig(services)
	fmt.Println(config)

	// write to file
	err := os.WriteFile("./config/Caddyfile.bird", []byte(config), 0644)
	if err != nil {
		panic(err)
	}
	fmt.Println("Caddyfile configured")
}

func generateConfig(services map[string]string) string {
	config := ""

	keys := make([]string, 0, len(services))

	for k := range services {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		if !strings.Contains(services[k], ".") { // normal deployment
			config += fmt.Sprintf(`%s.bird.karnwong.me {
    route {
    	reverse_proxy 192.168.1.122:%s
	}
}
`, k, services[k])
		} else { // knative
			config += fmt.Sprintf(`%s.bird.karnwong.me {
    route {
		reverse_proxy 192.168.1.122:31080 {
			header_up Host %s.example.com
		}
	}
}
`, k, services[k])
		}
	}

	return config
}
