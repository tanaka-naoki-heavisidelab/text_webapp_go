package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	dbUser := os.Getenv("MYSQL_USER")
	dbPassword := os.Getenv("MYSQL_PASSWORD")
	dbHost := os.Getenv("MYSQL_HOST")
	dbPort := os.Getenv("MYSQL_PORT")
	dbName := os.Getenv("MYSQL_DATABASE")
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPassword, dbHost, dbPort, dbName)
	db, err := sql.Open("mysql", dsn)

	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	query, err := ioutil.ReadFile("../setup.sql")
	if err != nil {
		log.Fatal(err)
	}

	_, err = db.Exec(string(query))
	if err != nil {
		log.Fatal(err)
	}
}
