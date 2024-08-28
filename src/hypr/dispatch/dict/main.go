package main

import (
	"fmt"
	"log"
	"os/exec"
	"strings"
)

func main() {
	terms := []string{"alacritty", "kitty", "konsole"}

	hyprctl := exec.Command("hyprctl", "activewindow")
	activeWindowOut, err := hyprctl.Output()
	if err != nil {
		log.Fatal("cannot get active window")
	}
	activewin := strings.Split(string(activeWindowOut), "\n")[12]
	title := strings.Split(strings.TrimSpace(activewin), ":")[1]

	client := strings.TrimSpace(title)
	fmt.Println(client)

	keyChord := "ctrl+c"

	for _, term := range terms {
		if client == term {
			keyChord = "ctrl+C"
		}
	}

	fmt.Printf("echo key %s\n", keyChord)

	// keyEventCmd := exec.Command("echo", fmt.Sprintf("key %s", keyChord), "|", "dotool")

	// err = keyEventCmd.Run()

	clipCmd := exec.Command("wl-paste")
	word, err := clipCmd.Output()

	fmt.Printf("dict %s\n", strings.TrimSpace(string(word)))

	dictCmd := exec.Command("dict", strings.TrimSpace(string(word)))
	meaning, err := dictCmd.Output()
	fmt.Println(err)
	fmt.Println(string(meaning))
}
