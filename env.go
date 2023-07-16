package main

import (
	"os"
	"strconv"
)

func GetAsString(key string, defaultValue string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}

	return defaultValue
}

func GetAsInt(name string, defaultValue int) int {
	valueStr := GetAsString(name, "")
	if value, err := strconv.Atoi(valueStr); err == nil {
		return value
	}

	return defaultValue
}
