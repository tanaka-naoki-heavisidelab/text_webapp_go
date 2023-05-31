package main

import (
	"fmt"
	"os"
)

type Command interface {
	Execute(args []string) error
}

type OneArgCommand struct {
}

func (cmd *OneArgCommand) Execute(args []string) error {
	fmt.Println("This is one arg command: ", args)
	return nil
}

type TwoArgsCommand struct {
}

func (cmd *TwoArgsCommand) Execute(args []string) error {
	fmt.Println("This is two args command: ", args)
	return nil
}

func main() {

	command := map[string]Command{
		"drop":   &OneArgCommand{},
		"insert": &TwoArgsCommand{},
	}

	if len(os.Args) < 2 {
		fmt.Println("No command provided")
		os.Exit(1)
	}

	cmdName := os.Args[1]
	cmdArgs := os.Args[2:]

	cmd, ok := command[cmdName]
	if !ok {
		fmt.Println("Invalid command:", cmdName)
	}

	err := cmd.Execute(cmdArgs)
	if err != nil {
		fmt.Println("Error executing command:", err)
		os.Exit(1)
	}
}
