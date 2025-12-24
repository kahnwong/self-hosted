package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {
	services := map[string]string{
		"api.qrcode":       "30077",
		"api.weather":      "30078",
		"authentik":        "30047",
		"cpubench":         "30080",
		"garage":           "30070",
		"git":              "30026",
		"go":               "go-playground.playground",
		"harbor":           "30500",
		"immich":           "30030",
		"jellyfin":         "jellyfin.media",
		"llm-context":      "30055",
		"matrix":           "6167",
		"miniflux":         "30007",
		"music":            "30006",
		"n8n":              "5678",
		"nocodb":           "30062",
		"ntfy":             "30022",
		"paperless":        "30079",
		"qa-api":           "30043",
		"rally":            "30035",
		"rustpad":          "rustpad.tools",
		"secrets":          "30025",
		"subsonic-widgets": "30038",
		"syncthing":        "8384",
		"thai-tech-cal":    "thai-tech-cal.news",
		"wakapi":           "30041",
	}
	servicesForwardAuth := map[string]string{
		"homer":           "30053",
		"k.console.notes": "notes-console-k.notes",
		"linkding":        "30005",
		"livegrep":        "30033",
		"notes":           "30052",
		"np":              "30084",
		"opencost":        "30054",
		"pdf":             "stirling-pdf.tools",
		"t.console.notes": "notes-console-t.notes",
		"todotxt":         "30064",
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

func generateConfig(services map[string]string) string {
	config := ""

	keys := make([]string, 0, len(services))

	for k := range services {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		if !strings.Contains(services[k], ".") { // normal deployment
			config += fmt.Sprintf(`%s.karnwong.me {
    route {
		crowdsec
    	reverse_proxy 192.168.1.36:%s
	}
}
`, k, services[k])
		} else { // knative
			config += fmt.Sprintf(`%s.karnwong.me {
    route {
		crowdsec
		reverse_proxy 192.168.1.36:31080 {
			header_up Host %s.example.com
		}
	}
}
`, k, services[k])
		}
	}

	return config
}

func generateConfigForwardAuth(services map[string]string) string {
	config := ""

	keys := make([]string, 0, len(services))

	for k := range services {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		if !strings.Contains(services[k], ".") { // normal deployment
			config += fmt.Sprintf(`%s.karnwong.me {
    route {
		crowdsec
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
		} else { // knative
			config += fmt.Sprintf(`%s.karnwong.me {
    route {
		crowdsec
        reverse_proxy /outpost.goauthentik.io/* http://192.168.1.36:30047

        forward_auth http://192.168.1.36:30047 {
            uri /outpost.goauthentik.io/auth/caddy
            copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
            trusted_proxies private_ranges
        }

        reverse_proxy 192.168.1.36:31080 {
            header_up Host %s.example.com
        }
    }
}
`, k, services[k])
		}
	}

	return config
}
