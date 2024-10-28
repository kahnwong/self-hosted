package main

import (
	"fmt"
	"os"
	"sort"
)

func main() {
	services := map[string]int{
		"audiobookshelf":   30027,
		"authentik":        30047,
		"books":            30032,
		"console.minio":    30021,
		"excalidraw":       30034,
		"gist":             30039,
		"git":              30026,
		"go":               30042,
		"harbor":           30500,
		"immich":           30030,
		"jellyfin":         30003,
		"memos":            30031,
		"miniflux":         30007,
		"minio":            30020,
		"music":            30006,
		"ntfy":             30022,
		"pdf":              30040,
		"plausible":        30044,
		"qa-api":           30045,
		"rustpad":          30019,
		"secrets":          30025,
		"share":            30017,
		"subsonic-widgets": 30038,
		"syncthing":        8384,
		"thai-tech-cal":    30046,
		"wakapi":           30041,
	}
	servicesForwardAuth := map[string]int{
		"console.mlflow": 30037,
		"dashy":          30023,
		"gatus":          30029,
		"linkding":       30005,
		"livegrep":       30033,
		"podgrab":        30004,
	}

	// generate config
	config := generateConfig(services)
	configForwardAuth := generateConfigForwardAuth(servicesForwardAuth)

	configAll := config + configForwardAuth
	fmt.Println(configAll)

	// write to file
	err := os.WriteFile("./config/Caddyfile", []byte(configAll), 0644)
	if err != nil {
		panic(err)
	}
	fmt.Println("Caddyfile configured")
}

func generateConfig(services map[string]int) string {
	config := ""

	keys := make([]string, 0, len(services))

	for k := range services {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		config += fmt.Sprintf(`%s.karnwong.me {
    reverse_proxy 192.168.1.36:%v
}
`, k, services[k])
	}

	return config
}

func generateConfigForwardAuth(services map[string]int) string {
	config := ""

	keys := make([]string, 0, len(services))

	for k := range services {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		config += fmt.Sprintf(`%s.karnwong.me {
    route {
        reverse_proxy /outpost.goauthentik.io/* http://192.168.1.36:30047

        forward_auth http://192.168.1.36:30047 {
            uri /outpost.goauthentik.io/auth/caddy
            copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
            trusted_proxies private_ranges
        }

        reverse_proxy 192.168.1.36:%v
    }
}
`, k, services[k])
	}

	return config
}
