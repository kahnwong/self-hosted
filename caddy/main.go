package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {
	services := map[string]string{
		"audiobookshelf":   "audiobookshelf.media",
		"authentik":        "30047",
		"books":            "calibre-web.media",
		"ci":               "32442",
		"console.minio":    "30021",
		"excalidraw":       "excalidraw.tools",
		"gist":             "opengist.tools",
		"git":              "30026",
		"go":               "go-playground.playground",
		"habits":           "30056",
		"harbor":           "30500",
		"hoarder":          "30054",
		"immich":           "30030",
		"jellyfin":         "jellyfin.media",
		"memos":            "30031",
		"miniflux":         "30007",
		"minio":            "30020",
		"music":            "30006",
		"ntfy":             "30022",
		"pdf":              "30040",
		"plausible":        "30044",
		"qa-api":           "30043",
		"rustpad":          "rustpad.tools",
		"secrets":          "30025",
		"share":            "picoshare.tools",
		"slash":            "30055",
		"subsonic-widgets": "30038",
		"syncthing":        "8384",
		"thai-tech-cal":    "thai-tech-cal.news",
		"wakapi":           "30041",
	}
	servicesForwardAuth := map[string]string{
		"gatus":             "30029",
		"grafana.teslamate": "30058",
		"homer":             "30053",
		"k.console.notes":   "notes-console-k.notes",
		"linkding":          "30005",
		"livegrep":          "30033",
		"notes":             "30052",
		"podgrab":           "30004",
		"t.console.notes":   "notes-console-t.notes",
		"teslamate":         "30059",
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
    reverse_proxy 192.168.1.36:%s
}
`, k, services[k])
		} else { // knative
			config += fmt.Sprintf(`%s.karnwong.me {
    reverse_proxy 192.168.1.36:31080 {
        header_up Host %s.example.com
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
